MIBDIR = /usr/share/snmp/mibs

all: snmp.yml

snmp.yml: generator.yml $(MIBDIR)
	podman run --rm \
		-v /usr/share/snmp/mibs:/mibs \
		-v $(PWD):/config:z \
		-w /config \
		docker.io/prom/snmp-generator -m /mibs generate

$(MIBDIR):
	@echo "MIB directory $@ does not exist. Have you installed the necessary package?" >&2; exit 1

clean:
	rm -f snmp.yml
