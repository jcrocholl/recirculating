length = 50;
thickness = 11;
channel_radius = 3;
track_radius = 6;
outside_radius = channel_radius + track_radius + 1.5;
separation = 12 + 2 * (channel_radius + track_radius);
slot = 2.5;

module track(h) {
  union() {
    translate([0, outside_radius-length/2, 0]) intersection() {
      rotate_extrude($fn=24) translate([track_radius, 0, 0])
        circle(r=channel_radius, $fn=6);
      translate([0, -20, 0]) cube([40, 40, 40], center=true);
    }
    translate([0, length/2-outside_radius, 0]) intersection() {
      rotate_extrude($fn=24) translate([track_radius, 0, 0])
        circle(r=channel_radius, $fn=6);
      translate([0, 20, 0]) cube([40, 40, 40], center=true);
    }
    for (s = [-1, 1]) {
      scale([s, 1, 1])
        translate([track_radius, 0, 0]) rotate([90, 0, 0])
        cylinder(r=channel_radius,
                 h=length-2*outside_radius+0.1,
                 center=true, $fn=6);
    }
  }
}

module half() {
  difference() {
    translate([0, 0, slot/2-thickness+1.3])
    linear_extrude(height=thickness) {
      difference() {
        translate([-0.5, 0, 0]) minkowski() {
          square([0.1, 0.1+length-2*outside_radius], center=true);
          circle(r=outside_radius-0.05, $fn=36);
        }
        for (y = [2+outside_radius-length/2,
                  length/2-outside_radius-2]) {
          translate([0, y])
            circle(r=1.5, $fn=12);
        }
      }
    }
    track();
    translate([10+track_radius, 0, -10-slot/2])
      cube([20, length, 20], center=true);
    translate([10+track_radius, 0, 10+slot/2])
      cube([20, length, 20], center=true);
  }
}

for (s = [1]) {
  scale([s, 1, 1]) half(1.5);
}