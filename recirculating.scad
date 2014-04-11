$fn=24;
length = 50;
thickness = 6;
channel_radius = 25.4 * 3 / 64 + 0.2;
track_radius = 4;
separation = 13 + 2 * (channel_radius + track_radius);

module track(h) {
  difference() {
    translate([-2, 0, -h/2])
      cube([12, length, h], center=true);
    translate([0, 8-length/2, 0]) # intersection() {
      rotate_extrude() translate([track_radius, 0, 0])
        circle(r=channel_radius);
      translate([0, -20, 0]) cube([40, 40, 40], center=true);
    }
    translate([0, length/2-8, 0]) # intersection() {
      rotate_extrude() translate([track_radius, 0, 0])
        circle(r=channel_radius);
      translate([0, 20, 0]) cube([40, 40, 40], center=true);
    }
    for (x = [-track_radius, track_radius]) {
      translate([x, 0, 0]) rotate([90, 0, 0]) #
        cylinder(r=channel_radius, h=length-15.9, center=true);
    }
    for (y = [-12, 12]) {
      translate([0, y, 0]) cylinder(r=1.5, h=20, center=true);
    }
  }
}

module recirculating() {
  difference() {
    union() {
      for (s = [-1, 1]) {
        scale([s, 1, 1])
          translate([-separation/2, 0, thickness])
          track(thickness);
      }
      translate([0, 0, 1])
        cube([17, length-10, 2], center=true);
    }
  }
}

recirculating();

for (s = [-1, 1]) {
  scale([s, 1, 1]) translate([32, 0, 3]) track(3);
}