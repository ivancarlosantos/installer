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
sleep(5);

printf("\tProcesso Realizado com Sucesso !!!\n");
return 0;

}