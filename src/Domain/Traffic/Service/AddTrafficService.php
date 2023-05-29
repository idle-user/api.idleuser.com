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
        $requestText = $requestMethod . ' ' . $requestPath;
        $requestBody = $request->getParsedBody();

        $userAgent = $request->getHeaderLine('HTTP_USER_AGENT');
        [$ipAddress, $requestBody['ipType']] = $this->getIpAddress($request);

        $cleanBodyKeys = ['secret' => '', 'password' => '',  'temp_secret' => '', 'auth_token' => '', 'login_token' => '', 'token' => '', 'auth' => ''];

        $requestBody = array_replace($requestBody, array_intersect_key($cleanBodyKeys, $requestBody));
        $requestBody = json_encode($requestBody);

        $traffic = $this->trafficRepository->addTraffic($domain, $requestText, $userAgent, $ipAddress, null, $requestBody);

        return $traffic;
    }

    private function getIpAddress($request)
    {
        $ipVars = [
            'HTTP_CF_CONNECTING_IP',
            'HTTP_CLIENT_IP',
            'HTTP_X_FORWARDED_FOR',
            'HTTP_X_FORWARDED',
            'HTTP_X_CLUSTER_CLIENT_IP',
            'HTTP_FORWARDED_FOR',
            'HTTP_FORWARDED',
            'REMOTE_ADDR'
        ];
    
        $privateIP = '';
        $privateIPType = '';
    
        foreach ($ipVars as $ipVar) {
            if (array_key_exists($ipVar, $_SERVER) === true) {
                foreach (explode(',', $_SERVER[$ipVar]) as $ip) {
                    $ip = trim($ip);
                    if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4 | FILTER_FLAG_IPV6) !== false) {
                        if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) !== false) {
                            return [$ip, $ipVar];
                        } elseif ($privateIP === '') {
                            $privateIP = $ip;
                            $privateIPType = $ipVar;
                        }
                    }
                }
            }
        }

        if ($privateIP === '') {
            $privateIP = '0.0.0.0';
            $privateIPType = 'UNKNOWN';
        }
    
        return [$privateIP, $privateIPType];
    }

}
