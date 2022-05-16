mysql -h localhost -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE <<END
INSERT INTO user (username, secret, access, date_created) VALUES ('admin', '\$2y\$10\$z21CfhGFmUqFImVjHq.EW.2NuYCN5Gc/IDxOHY2glMhWe4WKioWZO', 3, NOW());
INSERT INTO api_auth (auth_token,auth_token_exp,user_id,created,last_updated) VALUES (UUID_TO_BIN('$API_KEY'), '2050-12-31', 0, NOW(), NOW());
END
