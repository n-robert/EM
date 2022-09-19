<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;
use Inertia\Inertia;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind('\Illuminate\Routing\UrlGenerator', 'App\Http\Routing\EMUrlGenerator');
        $this->app->bind('Illuminate\Routing\Redirector', 'App\Http\Routing\EMRedirector');

        if ($this->app->environment('local')) {
            $this->app->register(\Laravel\Telescope\TelescopeServiceProvider::class);
            $this->app->register(TelescopeServiceProvider::class);
        } else {
            URL::forceScheme('https');
        }
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Inertia::share(
            [
                'errors' => function () {
                    return
                        Session::get('errors') ?
                            Session::get('errors')->getBag('default')->getMessages() : (object)[];
                },

                'canEdit' => function () {
                    return Gate::allows('can-edit');
                },

                'locale' => function () {
                    return app()->getLocale();
                },

                'language' => function () {
                    return get_translations();
                },

                '_token' => function () {
                    return csrf_token();
                },

                'views' => function () {
                    return session('views');
                },

                'defaultDateFormat' => function () {
                    return 'dd-MM-yyyy';
                },

                'currentRouteName' => function () {
                    return Route::currentRouteName();
                }
            ]
        );
    }
}
