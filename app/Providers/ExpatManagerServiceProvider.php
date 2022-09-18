<?php

namespace App\Providers;

use App\Contracts\RepositoryInterface;
use App\Http\Routing\EMUrlGenerator;
use App\Repositories\Eloquent\BaseRepository;
use Carbon\Carbon;
use Illuminate\Database\Query\Builder as QueryBuilder;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Schema\Grammars\PostgresGrammar;
use Illuminate\Routing\UrlGenerator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Str;

class ExpatManagerServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(RepositoryInterface::class, BaseRepository::class);
        $this->app->bind(UrlGenerator::class, EMUrlGenerator::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
//        $fileSystem = app('files');
//        $systemViews = $fileSystem->files(config('app.xml_form_path')['system']['item']);
//        $models = [];
//
//        foreach ($systemViews as $file) {
//            $forbidden = ['Country', 'Staff'];
//            $baseName = str_replace(['.', $file->getExtension()], '', $file->getFilename());
//
//            if (!in_array($baseName, $forbidden)) {
//                $models[] = strtolower($baseName);
//            }
//        }

        $models = ['employee', 'employer', 'permit', 'quota', 'occupation', 'address'];
        session(['views' => $models]);

        Route::group(['middleware' => config('jetstream.middleware', ['web'])], function () use ($models) {
            Route::group(['middleware' => ['auth', 'verified']], function () use ($models) {
                foreach ($models as $model) {
                    $view = $model;
                    $views = Str::plural($model);
                    $modelClass = ucfirst($model);
                    $controllerClass = 'App\\Http\\Controllers\\' . $modelClass . 'Controller';

                    // Bind model to route parameters: 'employee', 'employer', 'address'
                    Route::model($model, 'App\\Models\\' . $modelClass);

                    // View items
                    Route
                        ::get('/' . $views, $controllerClass . '@showAll')
                        ->middleware('query.validate')
                        ->name('gets.' . $views);
                    // Apply filter to items view
                    Route::post('/' . $views, $controllerClass . '@applyFilter');
                    // View item
                    Route
                        ::get('/' . $view . '/{id}', $controllerClass . '@show')
                        ->where('id', 'new|[0-9]+')
                        ->name('gets.' . $view);
                    // Delete item
                    Route::post('/' . $view . '/delete', $controllerClass . '@delete');
                    // Store new item
                    Route::post('/' . $view . '/store/', $controllerClass . '@store');
                    // Update existing item
                    Route
                        ::post('/' . $view . '/update/{' . $model . '}', $controllerClass . '@update')
                        ->where($model, '[0-9]+');
                }

                Route::post('/get-options/{dir}/{name}/{id}',
                    'App\Http\Controllers\BaseController@getFormFields');
                Route::post('/print/{doc}/{id}', 'App\Http\Controllers\BaseController@printDoc');
            });
        });

        // Add custom language file
        $translator = Carbon::getTranslator();
        $translator->addResource('array', require base_path('resources/lang/ru/customCarbonRu.php'), 'ru');

        QueryBuilder::macro(
            'whereNotEmpty',
            function (string $column, bool $distinct = true) {
                $this
                    ->distinct($distinct)
                    ->whereNotNull($column);
                if (str_ends_with($column, '_id')) {
                    $this->where($column, '!=', 0);
                } else {
                    $this->where($column, '!=', '""');
                }

                return $this;
            }
        );

        Builder::macro(
            'whereNotEmpty',
            function (string $column, bool $distinct = true) {
                return
                    $this
                        ->getQuery()
                        ->whereNotEmpty($column, $distinct);
            }
        );

        if (DB::connection()->getName() == 'pgsql') {
            DB::connection()->setSchemaGrammar(new class extends PostgresGrammar
            {
                protected function typeInt_array(\Illuminate\Support\Fluent $column)
                {
                    return 'int[]';
                }
            });
        }
    }
}
