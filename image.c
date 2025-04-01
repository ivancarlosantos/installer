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

printf("Removendo container");
sleep(3);
system("docker rm api-powerkr");
sleep(3);

printf("Listando Imagens\n");
sleep(3);
system("docker images");
sleep(3);

printf("Removendo Imagem Backend\n");
sleep(3);
system("docker rmi registry.digitalocean.com/api-powerkr-image/api-powerkr");
sleep(5);

printf("Executando Docker Backend\n");
sleep(3);
system("docker run --name api-powerkr -d 
    -p 8080:8080 
    --network=app-obs 
    -e DB_PASSWORD='' 
    -e DB_URL='' 
    -e DB_USER='' 
    -e GPT_API_KEY='' 
    -e TOKEN_SECRET='' 
    -e BUCKET_URL='' 
    -e GOOGLE_ID='' 
    -e GOOGLE_SECRET='' 
    registry.digitalocean.com/api-powerkr-image/api-powerkr");
sleep(5);

printf("\tProcesso Realizado com Sucesso !!!\n");
return 0;

}