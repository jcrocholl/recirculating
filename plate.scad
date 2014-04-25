thickness = 3;
outside_radius = 8;
separation = 29;
spacing = 25;

module plate(h) {
  linear_extrude(height=h) difference() {
    minkowski() {
      square([0.1+separation, 0.1+spacing], center=true);
      circle(r=outside_radius-0.05, $fn=36);
    }
    for (x = [-separation/2, separation/2]) {
      for (y = [-spacing/2, spacing/2]) {
        translate([x, y])
          circle(r=1.5, $fn=12);
      }
    }
  }
}

translate([0, 0, thickness/2])
  plate(thickness);
