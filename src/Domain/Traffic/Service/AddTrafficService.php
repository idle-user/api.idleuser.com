<?php

declare(strict_types=1);

namespace App\Domain\Traffic\Service;

use Psr\Http\Message\ServerRequestInterface as Request;

final class AddTrafficService extends TrafficService
{
    public function run(Request $request)
    {
        $domain = $_SERVER['HTTP_HOST'];
        $requestMethod = $request->getMethod();
        $requestPath = $request->getUri()->getPath();
        $requestText = "${requestMethod} ${requestPath}";

        $userAgent = $request->getHeader('User-Agent')[0];
        # check cloudflare
        if (isset($_SERVER['HTTP_CF_CONNECTING_IP'])) {
            $ipAddress = $_SERVER['HTTP_CF_CONNECTING_IP'];
        } else {
            $ipAddress = $request->getAttribute('ip_address');
        }
        $userId = $request->getAttribute('auth')->getUserId();

        $traffic = $this->trafficRepository->addTraffic($domain, $requestText, $userAgent, $ipAddress, $userId);

        return $traffic;
    }
}
