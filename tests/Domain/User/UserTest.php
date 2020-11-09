<?php
declare(strict_types=1);

namespace Tests\Domain\User;

use App\Domain\User\Data\User;
use Tests\TestCase;

class UserTest extends TestCase
{
    public function userProvider()
    {
        return [
            [1, 'bill.gates'],
            [2, 'steve.jobs'],
            [3, 'mark.zuckerberg'],
            [4, 'evan.spiegel'],
            [5, 'jack.dorsey'],
        ];
    }

    /**
     * @dataProvider userProvider
     * @param $id
     * @param $username
     */
    public function testGetters($id, $username)
    {
        $user = new User($id, $username);

        $this->assertEquals($id, $user->getId());
        $this->assertEquals($username, $user->getUsername());
    }

    /**
     * @dataProvider userProvider
     * @param $id
     * @param $username
     */
    public function testJsonSerialize($id, $username)
    {
        $user = new User($id, $username);

        $expectedPayload = json_encode([
            'id' => $id,
            'username' => $username,
        ]);

        $this->assertEquals($expectedPayload, json_encode($user));
    }
}
