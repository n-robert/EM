<?php

namespace App\Providers;

use App\Contracts\RepositoryInterface;
use App\Models\Team;
use App\Services\XmlFormHandlingService;
use Carbon\Carbon;
use Illuminate\Database\Query\Builder as QueryBuilder;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Schema\Grammars\PostgresGrammar;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Str;

class ExpatManagerServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        Gate::define('is-admin', function ($user) {
            // An admin owns a team named "admin"
            if ($adminTeam = Team::query()->where(['name' => 'admin'])->first()) {
                return $user->hasTeamRole($adminTeam, 'admin');
            }

            // or is the first user
            return $user->id == 1;
        });

        Gate::define('can-edit', function ($user) {
            return $user->teams->contains(function ($team, $key) use ($user) {
                return $user->hasTeamRole($team, 'admin');
            });
        });

        Route::group(['middleware' => config('jetstream.middleware', ['web'])], function () {
            Route::group(['middleware' => ['auth', 'verified']], function () {
                $models = XmlFormHandlingService::getModelList();

                foreach ($models as $model) {
                    $view = $model;
                    $views = Str::plural($model);
                    $modelClass = ucfirst($model);
                    $controllerClass = 'App\\Http\\Controllers\\' . $modelClass . 'Controller';

                    // Bind model to route parameters: 'employee', 'employer', 'address'
                    Route::model($model, 'App\\Models\\' . $modelClass);

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
                    // View items
                    Route
                        ::get('/' . $views, $controllerClass . '@showAll')
                        ->middleware('query.validate')
                        ->name('gets.' . $views);
                    // Get items
                    Route
                        ::post('/' . $views, $controllerClass . '@getItems')
                        ->middleware('query.validate')
                        ->name('posts.' . $views);
                    // Apply filter to items view
                    Route::post('/' . $views, $controllerClass . '@applyFilter');
                }

                Route::post('/staff/{year}/{month}', 'App\Http\Controllers\StaffController@staffByMonth');
                Route::post('/get-options/{dir}/{name}/{id}',
                    'App\Http\Controllers\BaseController@getFormFields');
                Route::post('/print/{doc}/{id}', 'App\Http\Controllers\BaseController@printDoc');
            });
        });

        // Add custom language file to Carbon
        $translator = Carbon::getTranslator();
        $translator->addResource('array', require base_path('resources/lang/ru/customCarbonRu.php'), 'ru');

        // Custom whereNotEmpty for Illuminate\Database\Eloquent\Builder
        // Will return Illuminate\Database\Query\Builder::whereNotEmpty()
        Builder::macro(
            'whereNotEmpty',
            function (string $column) {
                return
                    $this
                        ->getQuery()
                        ->whereNotEmpty($column);
            }
        );

        // Custom whereNotEmpty for Illuminate\Database\Query\Builder
        QueryBuilder::macro(
            'whereNotEmpty',
            function (string $column) {
                $this->whereNotNull($column);

                if (str_ends_with($column, '_id')) {
                    $this->where($column, '!=', 0);
                } else {
                    $this->where($column, '!=', '""');
                }

                return $this;
            }
        );

        if (DB::connection()->getName() == 'pgsql') {
            DB::connection()->setSchemaGrammar(new class extends PostgresGrammar {
                protected function typeInt_array(\Illuminate\Support\Fluent $column)
                {
                    return 'int[]';
                }
            });
        }
    }
}
