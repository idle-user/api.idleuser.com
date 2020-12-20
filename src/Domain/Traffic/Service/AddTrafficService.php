<?php

declare(strict_types=1);

namespace App\Domain\Traffic\Service;

use App\Domain\Traffic\Service\TrafficService;
use Psr\Http\Message\ServerRequestInterface as Request;

final class AddTrafficService extends TrafficService
{
    public function run(Request $request)
    {
        $requestMethod = $request->getMethod();
        $requestPath = $request->getUri()->getPath();
        $requestText = "${requestMethod} ${requestPath}";

        $userAgent = $request->getHeader('User-Agent')[0];
        $ipAddress = $request->getAttribute('ip_address');

        $traffic = $this->trafficRepository->addTraffic($requestText, $userAgent, $ipAddress);

        return $traffic;
    }
}
