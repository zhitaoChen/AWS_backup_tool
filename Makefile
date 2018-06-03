prefix=/usr/local

install: ec2-backup
	install -m 0777 ec2-backup $(prefix)/bin

.PHONY: install