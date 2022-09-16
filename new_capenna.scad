module capenna() {
    linear_extrude(height = 10)
    import("/new_capenna_logo.svg", $fn =  256);
}

translate([-112, -160, 0])
capenna();
