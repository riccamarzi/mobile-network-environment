GRANT DELETE,INSERT,SELECT,UPDATE ON icscf.* to icscf@'%' identified by 'heslo';
GRANT DELETE,INSERT,SELECT,UPDATE ON icscf.* to provisioning@'%' identified by 'provi';
GRANT ALL PRIVILEGES ON icscf.* TO 'icscf'@'%' identified by 'heslo';
GRANT ALL PRIVILEGES ON icscf.* TO 'provisioning'@'%' identified by 'provi';
FLUSH PRIVILEGES;
