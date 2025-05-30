#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(){

printf("\tConectando ao Registry Container Digitalocean\n");
sleep(4);

printf("\tListando Containers\n");
sleep(3);
system("docker ps -a");
sleep(3);

printf("\tParar Container Backend\n");
sleep(3);
system("docker container stop api-powerkr");
sleep(3);

printf("\tDesconectar api-powerkr da rede Docker\n");
sleep(3);
system("docker network disconnect app-obs api-powerkr");
sleep(3);

printf("\tRemovendo container\n");
sleep(3);
system("docker rm api-powerkr");
sleep(3);

printf("\tListando Imagens\n");
sleep(3);
system("docker images");
sleep(3);

printf("\tRemovendo Imagem Backend\n");
sleep(3);
system("docker rmi registry.digitalocean.com/api-powerkr-image/api-powerkr");
sleep(5);

printf("\tExecutando Docker api-powerkr Backend\n");
sleep(3);
system("");
sleep(5);printf("\tVerificando Vulnerabilidades de Segurança dos Containers\n");
sleep(2);

printf("\tVerificando o processo do container api-powerkr\n");
sleep(3);
system("hostnamectl");
sleep(3);
system("docker top api-powerkr");
sleep(5);

printf("\tRealizando Docker Scout\n");
sleep(3);
system("docker scout cves registry.digitalocean.com/api-powerkr-image/api-powerkr:latest");
sleep(3);

printf("\tRealizando Docker Security Bench\n");
sleep(3);
system("docker run -it --rm --net host --pid host --cap-add audit_control -v /var/lib:/var/lib -v /var/run/docker.sock:/var/run/docker.sock -v /usr/lib/systemd:/usr/lib/systemd -v /etc:/etc --label docker_bench_security docker/docker-bench-security");
sleep(3);

printf("\tRealizando Trivy Scan\n");
sleep(3);
system("docker run -it --rm -v trivy-cache:/root/.cache/ -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image registry.digitalocean.com/api-powerkr-image/api-powerkr:latest");
sleep(3);

printf("\tMostrar Recomendações de Melhorias de Segurança na Imagem api-powerkr\n");
sleep(3);
system("docker scout recommendations registry.digitalocean.com/api-powerkr-image/api-powerkr:latest");
sleep(3);

printf("\tProcesso Realizado com Sucesso !!!\n");
return 0;

}
