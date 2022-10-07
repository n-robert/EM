<?php

namespace App\Http\Controllers;

use App\Contracts\ControllerInterface;
use Illuminate\Http\RedirectResponse;
use Illuminate\Routing\Controller;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\URL;
use Inertia\Response as InertiaResponse;
use Laravel\Jetstream\Jetstream;
use Illuminate\Support\Str;
use App\Services\PdfFormFillingService;
use App\Services\XmlFormHandlingService;

class BaseController extends Controller implements ControllerInterface
{
    /**
     * @var string
     */
    public $name;

    /**
     * @var string
     */
    public $names;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @var XmlFormHandlingService
     */
    protected $formHandlingService;

    /**
     * @var PdfFormFillingService
     */
    protected $formFillingService;

    /**
     * BaseController constructor.
     *
     * @param PdfFormFillingService $formFillingService
     * @param XmlFormHandlingService $formHandlingService
     * @param Request $request
     */
    public function __construct(
        PdfFormFillingService $formFillingService,
        XmlFormHandlingService $formHandlingService,
        Request $request
    ) {
        $this->formFillingService = $formFillingService;
        $this->formHandlingService = $formHandlingService;
        $this->request = $request;
        $this->name = strtolower(
            str_replace('Controller', '', class_basename(static::class))
        );
        $this->names = Str::plural($this->name);
    }

    /**
     * Handle dynamic method calls into the controller.
     *
     * @param  string $method
     * @param  array $parameters
     * @return mixed
     */
    public function __call($method, $parameters)
    {
        return
            method_exists($this, $method) ?
                $this->$method(...$parameters) :
                parent::__call($method, $parameters);
    }

    /**
     * Dynamically retrieve class field.
     *
     * @param  string $key
     * @return mixed
     */
    public function __get($key)
    {
        $class = ucfirst($this->name);

        switch ($key) {
            case 'model':
                $class = 'App\\Models\\' . $class;
                break;
            case 'requestValidation':
                $class = 'App\\Http\\Requests\\' . $class . 'RequestValidation';
                break;
            case 'repository':
                $class = 'App\\Repositories\\Eloquent\\' . $class . 'Repository';
                break;
        }

        return app($class);
    }

    /**
     * Apply a filter from request.
     *
     * @return mixed
     */
    public function applyFilter()
    {
//        dd($this->request->input());
        $name = $this->request->get('name', '');
        $field = $this->request->get('field', '');
        $value = $this->request->get('value', '');
        $action = $this->request->get('action', '');

        if (!$field) {
            return true;
        }

        try {
            if (!($value && $action)) {
                throw new \Exception(__('Not enough parameters.'));
            }

            if (!in_array($action, ['remove', 'put'])) {
                throw new \Exception(__('Illegal action.'));
            }

            $key = $this->names . '.filters.';
            $key .= is_array($value) ? $field . '.' . $name : $field . '.' . $value;

            $args =
                $action == 'remove' ? [$key] :
                    ($action == 'put' ? [$key, $value] : []);
            Session::$action(...$args);
        } catch (\Exception $e) {
            abort(404, $e->getMessage());
        }

        session(['filtersModal' => true]);

        return redirect()->route('gets.' . $this->names);
    }

    /**
     * Delete a record.
     *
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function delete()
    {
        try {
            $id = $this->request->input('id');
            $this->model->find($id)->delete();
        } catch (\Exception $e) {
            abort(404, $e->getMessage());
        }

        return redirect()->route('gets.' . $this->names);
    }

    /**
     * Get form fields from XML-file.
     * @param $dir
     * @param $name
     * @param $id
     * @return array
     */
    public function getFormFields($dir, $name, $id)
    {
        return call_user_func_array(
            [$this->formHandlingService, 'getFormFields'],
            [$dir, $name, $id]
        );
    }

    /**
     * Print WPM form.
     *
     * @param string $doc
     * @param int $id
     * @return void
     */
    public function printDoc(string $doc, int $id)
    {
        $docData = $this->request->input();

        array_walk($docData, function (&$data) {
            $data = trim($data);
        });

        call_user_func_array(
            [$this->formFillingService, 'printDoc'],
            [$doc, $id, $docData]
        );
    }

    /**
     * Show item screen.
     *
     * @param  int|string $id
     * @return InertiaResponse
     */
    public function show($id): InertiaResponse
    {
        if (is_numeric($id)) {
            $item = $this->model->findOrFail($id);
        } else {
            $item = $this->model;
            $attributes = Schema::getColumnListing($this->model->names);

            foreach ($attributes as $attribute) {
                $item->setAttribute($attribute, ($attribute == 'user_ids') ? Auth::id() : null);
            }
        }

        $userIds = $item->user_ids ?: Auth::id();
        session([$this->name . '.user_ids' => $userIds]);

        $canEdit = Gate::allows('can-edit');
        $page = 'EM/Item';
        $page .= $canEdit ? 'Edit' : 'View';
        $action = $id > 0 ? 'update' : 'store';
        $formFields = call_user_func_array(
            [$this->formHandlingService, 'getFormFields'],
            ['system.item', $this->name, $id]
        );

        $requiredFields = $formFields['requiredFields'];
        unset($formFields['requiredFields']);

        return Jetstream::inertia()->render($this->request, $page, [
            'item'            => $item,
            'repeatable'      => $item->repeatable,
            'action'          => $action,
            'formFields'      => $formFields,
            'requiredFields'  => $requiredFields,
            'controllerName'  => $this->name,
            'controllerNames' => $this->names,
            'listUrl'         => URL::route('gets.' . $this->names, ['page' => session('page')], false),
        ]);
    }

    /**
     * Show items list.
     *
     * @return InertiaResponse
     */
    public function showAll(): InertiaResponse
    {
        $query =
            $this->model
                ->applyFilters()
                ->applyDefaultOrder()
                ->applyCustomClauses()
                ->select($this->model->listable);

        $items = $query->paginate(request('perPage'));

        $page = 'EM/Items';
        $filters = $this->model->getFilters();
        $hasFilters = session($this->names . '.filters') && !!array_filter(session($this->names . '.filters'));
        $pagination = $this->model->getPagination($items);
        $modal = [];
        $docList = [];

        foreach ($items->all() as $item) {
            $modal[$item->id] = false;
        }

        $modal['filters'] = session('filtersModal');
        session(['filtersModal' => false]);
        session(['page' => $this->request->input('page')]);

        call_user_func_array([$this->formHandlingService, 'checkDocList'], [$this->name, &$modal, &$docList]);

        $formFields = call_user_func_array(
            [$this->formHandlingService, 'getFormFields'],
            ['system.list', $this->names]
        );
        unset($formFields['requiredFields']);

        return Jetstream::inertia()->render($this->request, $page, [
            'items'           => $items->all(),
            'filters'         => $filters,
            'hasFilters'      => $hasFilters,
            'pagination'      => $pagination,
            'modal'           => $modal,
            'docList'         => $docList,
            'formFields'      => $formFields,
            'controllerName'  => $this->name,
            'controllerNames' => $this->names,
        ]);
    }

    /**
     * Store new record.
     *
     * @return RedirectResponse
     */
    public function store(): RedirectResponse
    {
        return $this->save();
    }

    /**
     * Bind request data and save model
     *
     * @param Model|null $model
     * @return RedirectResponse
     */
    public function save(Model $model = null): RedirectResponse
    {
        $attributes = $this->requestValidation->except('type');

        if (!$model) {
            $model = $this->model;
        }

        $model->setAttribute('user_ids', session($this->name . '.user_ids'));

        $model
            ->fill($attributes)
            ->save();

        return
            $this->request->input('type') == 'save' ?
                redirect()->route('gets.' . $this->names, ['page' => session('page')]) :
                redirect()->route('gets.' . $this->name, ['id' => $model->id]);
    }

    /**
     * Update existing record.
     *
     * @param Model $model
     * @return RedirectResponse
     */
    public function update(Model $model): RedirectResponse
    {
        return $this->save($model);
    }
}
