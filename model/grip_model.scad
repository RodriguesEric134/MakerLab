$fn = 64;

// ======================================================
// GRIP MODEL - GARRA EM FORMATO DE PINÇA
// Compatível com micro servo 9g
// Unidades em mm
// ======================================================

// ---------- PARÂMETROS DO SERVO ----------
servo_len = 23;       // comprimento do corpo do servo
servo_w   = 12.2;     // largura do corpo do servo
servo_h   = 24;       // altura do corpo do servo
clearance = 0.6;      // folga para encaixe

// ---------- PARÂMETROS GERAIS ----------
wall   = 3;
base_t = 4;

// ---------- PARÂMETROS DA GARRA ----------
body_len   = 18;      // corpo frontal da garra
body_w     = 26;      // largura do corpo frontal
body_h     = 10;      // altura do corpo frontal

finger_len      = 32; // comprimento dos dedos
finger_root_w   = 7;  // largura do dedo na base
finger_tip_w    = 4;  // largura do dedo na ponta
finger_t        = 8;  // espessura/altura do dedo
finger_gap_root = 14; // abertura entre dedos na base
finger_gap_tip  = 6;  // abertura entre dedos na ponta

mount_hole_d = 3;     // diâmetro dos furos de fixação

// ---------- MEDIDAS DERIVADAS ----------
servo_box_len = servo_len + 2*wall;
servo_box_w   = servo_w + 2*wall;
servo_box_h   = servo_h + base_t;

total_len = servo_box_len + body_len + finger_len;
total_w   = max(body_w, servo_box_w);

pocket_len = servo_len + 2*clearance;
pocket_w   = servo_w + 2*clearance;

// ======================================================
// MÓDULOS
// ======================================================

module servo_mount() {
    difference() {
        cube([servo_box_len, total_w, servo_box_h]);

        // cavidade para encaixe do servo
        translate([wall, (total_w - pocket_w)/2, base_t])
            cube([pocket_len, pocket_w, servo_h + 1]);
    }
}

module gripper_body() {
    translate([servo_box_len, (total_w - body_w)/2, 0])
        cube([body_len, body_w, body_h]);
}

module claw_finger(is_upper = true) {
    root_y = is_upper
        ? (total_w/2 + finger_gap_root/2)
        : (total_w/2 - finger_gap_root/2 - finger_root_w);

    tip_y = is_upper
        ? (total_w/2 + finger_gap_tip/2)
        : (total_w/2 - finger_gap_tip/2 - finger_tip_w);

    hull() {
        // base do dedo
        translate([servo_box_len + body_len, root_y, body_h - finger_t])
            cube([10, finger_root_w, finger_t]);

        // ponta do dedo
        translate([servo_box_len + body_len + finger_len - 8, tip_y, body_h - finger_t])
            cube([8, finger_tip_w, finger_t]);
    }
}

module claw_tip_pad(is_upper = true) {
    pad_y = is_upper
        ? (total_w/2 + finger_gap_tip/2 - 1)
        : (total_w/2 - finger_gap_tip/2 - 3);

    translate([servo_box_len + body_len + finger_len - 5, pad_y, body_h - finger_t])
        cube([5, 3, finger_t]);
}

// ======================================================
// PEÇA FINAL
// ======================================================

difference() {
    union() {
        servo_mount();
        gripper_body();
        claw_finger(true);   // dedo superior
        claw_finger(false);  // dedo inferior
        claw_tip_pad(true);
        claw_tip_pad(false);
    }

    // furos de fixação na base
    translate([servo_box_len/2 - 5, total_w/2, -1])
        cylinder(h = base_t + 2, d = mount_hole_d);

    translate([servo_box_len/2 + 5, total_w/2, -1])
        cylinder(h = base_t + 2, d = mount_hole_d);
}