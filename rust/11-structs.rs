#![allow(
    dead_code,
    unused_imports
    )]

trait Alas {
    fn volar(&self);
}

trait Cuerno {
    fn cornear(&self);
}

trait Torso {
    fn hablar(&self);
}

trait Caballo {
    fn caminar(&self);
    fn correr(&self);
    fn parar(&self);
}

struct Pegaso {
    color: String,
}

impl Pegaso {
    fn new(color: &str) -> Self {
        Pegaso {
            color: String::from(color),
        }
    }

    fn show(&self) {
        println!("{}", self.color);
    }
}

impl Caballo for Pegaso {
    fn caminar(&self) {
        println!("El Pegaso está caminando");
    }

    fn correr(&self) {
        println!("El Pegaso está corriendo");
    }

    fn parar(&self) {
        println!("El Pegaso ha parado");
    }
}

impl Alas for Pegaso {
    fn volar(&self) {
        println!("El Pegaso está volando");
    }
}

struct Unicornio {
    color: String,
}

impl Unicornio {
    fn new() -> Self {
        Unicornio {
            color: String::from("blanco"),
        }
    }

    fn show(&self) {
        println!("{}", self.color);
    }
}

impl Caballo for Unicornio {
    fn caminar(&self) {
        println!("El Unicornio está caminando");
    }

    fn correr(&self) {
        println!("El Unicornio está corriendo");
    }

    fn parar(&self) {
        println!("El Unicornio ha parado");
    }
}

impl Cuerno for Unicornio {
    fn cornear(&self) {
        println!("El Unicornio está corneando");
    }
}

struct Centauro {
    color: String,
}

impl Centauro {
    fn new(color: &str) -> Self {
        Centauro {
            color: String::from(color),
        }
    }

    fn show(&self) {
        println!("{}", self.color);
    }
}

impl Caballo for Centauro {
    fn caminar(&self) {
        println!("El Centauro está caminando");
    }

    fn correr(&self) {
        println!("El Centauro está corriendo");
    }

    fn parar(&self) {
        println!("El Centauro ha parado");
    }
}

impl Torso for Centauro {
    fn hablar(&self) {
        println!("El Centauro está hablando");
    }
}

fn main() {
    let p = Pegaso::new("negro");
    let u = Unicornio::new();
    let c = Centauro::new("café");

    p.show();
    u.show();
    c.show();

}
