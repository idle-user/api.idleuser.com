<?php

declare(strict_types=1);

namespace App\Domain\Traffic\Service;

use Psr\Http\Message\ServerRequestInterface as Request;

final class AddTrafficService extends TrafficService
{
    public function run(Request $request)
    {
        $domain = $request->getUri()->getHost();
        $requestMethod = $request->getMethod();
        $requestPath = $request->getUri()->getPath();
        $requestText = "${requestMethod} ${requestPath}";

        $userAgent = $request->getHeaderLine('HTTP_USER_AGENT');

        if ($request->hasHeader('HTTP_CF_CONNECTING_IP')) {
            $ipAddress = $request->getHeaderLine('HTTP_CF_CONNECTING_IP');
        } elseif ($request->hasHeader('HTTP_CLIENT_IP')) {
            $ipAddress = $request->getHeaderLine('HTTP_CLIENT_IP');
        } elseif ($request->hasHeader('HTTP_X_REAL_IP')) {
            $ipAddress = $request->getHeaderLine('HTTP_X_REAL_IP');
        } elseif ($request->hasHeader('X_FORWARDED_FOR')) {
            $ipAddress = $request->getHeaderLine('X_FORWARDED_FOR');
        } else {
            $ipAddress = $request->getHeaderLine('REMOTE_ADDR');
        }
        
        $traffic = $this->trafficRepository->addTraffic($domain, $requestText, $userAgent, $ipAddress);

        return $traffic;
    }
}
