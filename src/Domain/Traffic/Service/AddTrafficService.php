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

        if ($request->hasHeader('HTTP_CF_CONNECTING_IP')) {
            $ipAddress = $request->getHeaderLine('HTTP_CF_CONNECTING_IP');
            $requestBody['ipType'] = 'HTTP_CF_CONNECTING_IP';
        } elseif ($request->hasHeader('HTTP_CLIENT_IP')) {
            $ipAddress = $request->getHeaderLine('HTTP_CLIENT_IP');
            $requestBody['ipType'] = 'HTTP_CLIENT_IP';
        } elseif ($request->hasHeader('HTTP_X_REAL_IP')) {
            $ipAddress = $request->getHeaderLine('HTTP_X_REAL_IP');
            $requestBody['ipType'] = 'HTTP_X_REAL_IP';
        } elseif ($request->hasHeader('X_FORWARDED_FOR')) {
            $ipAddress = $request->getHeaderLine('X_FORWARDED_FOR');
            $requestBody['ipType'] = 'X_FORWARDED_FOR';
        } elseif ($request->hasHeader('REMOTE_ADDR')) {
            $ipAddress = $request->getHeaderLine('REMOTE_ADDR');
            $requestBody['ipType'] = 'REMOTE_ADDR';
        } else {
            $ipAddress = $request->getHeaderLine('HOST');
            $requestBody['ipType'] = 'HOST';
        }

        $cleanBodyKeys = ['secret' => '', 'password' => '',  'temp_secret' => '', 'auth_token' => '', 'login_token' => '', 'token' => '', 'auth' => ''];

        $requestBody = array_replace($requestBody, array_intersect_key($cleanBodyKeys, $requestBody));
        $requestBody = json_encode($requestBody);
        
        $traffic = $this->trafficRepository->addTraffic($domain, $requestText, $userAgent, $ipAddress, null, $requestBody);

        return $traffic;
    }
    
}
