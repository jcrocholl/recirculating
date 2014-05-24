length = 50;
thickness = 11;
channel_radius = 3;
track_radius = 6;
outside_radius = channel_radius + track_radius + 1.5;
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
        translate([track_radius, 0, 0]) rotate([90, 0, 0]) {
          cylinder(r=channel_radius,
                   h=length-2*outside_radius+0.1,
                   center=true, $fn=6);
          translate([0, 2, 0]) #
            cylinder(r=channel_radius*0.61,
                     h=length-2*outside_radius+0.1,
                     center=true, $fn=6);
      }
    }
  }
}

module support(h, w) {
  linear_extrude(height=h, convexity=2) {
    difference() {
      square([4, length-5], center=true);
      for (y = [-length:4:length]) {
        translate([w, y]) square([4, 2-w], center=true);
        translate([-w, y+2]) square([4, 2-w], center=true);
      }
    }
  }
}

module half() {
  difference() {
    translate([0, 0, slot/2-thickness+1.3])
    linear_extrude(height=30, convexity=2) {
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
    translate([-10.5, 0, 12.5]) difference() {
      cube([100, 100, 20], center=true);
      difference() {
        translate([0, 0, -10.5]) rotate([90, 0, 0]) rotate([0, 90, 0])
          cylinder(r=12, h=30, center=true, $fn=6);
        translate([-18, 0, 0]) rotate([0, 30, 0])
          cube([40, 40, 40], center=true);
      }
    }
    translate([0, 0, 10]) rotate([0, -90, 0]) {
      rotate([0, 0, 90]) cylinder(r=3.2, h=50, $fn=6);
      cylinder(r=1.7, h=50, center=true, $fn=12);
    }
    translate([10+track_radius, 0, -10-slot/2])
      cube([20, length, 20], center=true);
    translate([10+track_radius, 0, 10+slot/2])
      cube([20, length, 20], center=true);
  }
}

half(1.5);
translate([8.8, 0, slot/2-thickness+1.3]) support(h=7.1, w=0.6);

translate([15, 0, 0]) % cube([15, 100, 15], center=true);
