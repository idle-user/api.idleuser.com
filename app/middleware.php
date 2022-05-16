<?php
declare(strict_types=1);

use App\Application\Middleware\AuthMiddleware;
use App\Application\Middleware\TrafficMiddleware;
use Middlewares\TrailingSlash;
use Slim\App;

return function (App $app) {
    $app->add(TrafficMiddleware::class);
    $app->add(AuthMiddleware::class);
    $app->addBodyParsingMiddleware();
    $app->addRoutingMiddleware();
    $app->add(new TrailingSlash());
};
