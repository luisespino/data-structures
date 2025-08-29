#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct Caballo {
    char* color;
    void (*caminar)(void);
    void (*correr)(void);
    void (*parar)(void);  
} Caballo;


typedef struct Pegaso {
    Caballo base;
    void (*volar)(void);  
} Pegaso;


typedef struct Unicornio {
    Caballo base;
    void (*cornear)(void);  
} Unicornio;


typedef struct Centauro {
    Caballo base;
    void (*hablar)(void);  
} Centauro;


Caballo* crearCaballo() {
    Caballo* c = (Caballo*)malloc(sizeof(Caballo));
    c->color = "blanco";
    c->caminar = NULL;
    c->correr = NULL;
    c->parar = NULL;
    return c;
}


Pegaso* crearPegaso(const char* color) {
    Pegaso* p = (Pegaso*)malloc(sizeof(Pegaso));
    p->base.color = (char*)color;
    p->base.caminar = NULL;
    p->base.correr = NULL;
    p->base.parar = NULL;
    p->volar = NULL;  
    return p;
}


Unicornio* crearUnicornio() {
    Unicornio* u = (Unicornio*)malloc(sizeof(Unicornio));
    u->base.color = "blanco";
    u->base.caminar = NULL;
    u->base.correr = NULL;
    u->base.parar = NULL;
    u->cornear = NULL;  
    return u;
}


Centauro* crearCentauro(const char* color) {
    Centauro* c = (Centauro*)malloc(sizeof(Centauro));
    c->base.color = (char*)color;
    c->base.caminar = NULL;
    c->base.correr = NULL;
    c->base.parar = NULL;
    c->hablar = NULL;  
    return c;
}

void mostrarColor(char* color) {
    printf("%s\n", color);
}

int main() {
    Pegaso* p = crearPegaso("negro");
    Unicornio* u = crearUnicornio();
    Centauro* c = crearCentauro("cafe");

    mostrarColor(p->base.color);
    mostrarColor(u->base.color);
    mostrarColor(c->base.color);

    free(p);
    free(u);
    free(c);

    return 0;
}
