DOCKER_CONTAINER_MININET = mininet
DOCKER_IMAGE_MININET = jingqiu/docker-mininet-auto
DOCKER_IMAGE_TCPDUMP = jingqiu/docker-tcpdump
CMD_START_OVS = service openvswitch-switch start
CMD_START_MN = sudo mn --custom /projects/topo.py --topo SimTopo --link tc1

.PHONY: docker-mininet docker-tcpdump

build: docker-mininet docker-tcpdump

docker-mininet:
	docker pull $(DOCKER_IMAGE_MININET)

docker-tcpdump:
	docker pull $(DOCKER_IMAGE_TCPDUMP)

run: clean start_container
	docker exec -it $(DOCKER_CONTAINER_MININET) $(CMD_START_MN)

start_container:
	docker run --privileged --cap-add=ALL -v /lib/modules:/lib/modules -d -it --name $(DOCKER_CONTAINER_MININET) $(DOCKER_IMAGE_MININET)
	docker cp topo.py $(DOCKER_CONTAINER_MININET):/projects/
	docker exec $(DOCKER_CONTAINER_MININET) $(CMD_START_OVS)

clean:
	@docker rm -f $(DOCKER_CONTAINER_MININET) 2>/dev/null || true
