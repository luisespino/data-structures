fn main() {
    let stack_var = 10;
    println!("Stack value: {}", stack_var);

    let heap_var = Box::new(20);
    println!("Heap value: {}", heap_var);

}