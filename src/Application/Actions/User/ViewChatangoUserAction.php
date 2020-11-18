<?php
declare(strict_types=1);

namespace App\Application\Actions\User;

use App\Domain\User\Service\ViewChatangoUserService;
use App\Application\Actions\Action;
use Psr\Log\LoggerInterface;
use Psr\Http\Message\ResponseInterface as Response;

class ViewChatangoUserAction extends Action
{
    private $ViewChatangoUserservice;

    public function __construct(LoggerInterface $logger, ViewChatangoUserService $ViewChatangoUserservice)
    {
        parent::__construct($logger);
        $this->ViewChatangoUserservice = $ViewChatangoUserservice;
    }

    /**
     * {@inheritdoc}
     */
    protected function action(): Response
    {
        $chatangoId = (string) $this->resolveArg('chatangoId');

        $user = $this->ViewChatangoUserservice->run($chatangoId);

        return $this->respondWithData($user);
    }
}
