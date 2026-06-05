$fn = 64;

// ======================================================
// SERVO LINK MODEL - ELO ROBÓTICO COM SUPORTE PARA SERVO 9g
// Projeto: DataBurn / SpaceFire Monitor
// Unidades em mm
// ======================================================

// ---------- PARÂMETROS DO SERVO 9g ----------
servo_len = 23;
servo_w   = 12.2;
servo_h   = 24;
clearance = 0.6;

// ---------- PARÂMETROS DO SUPORTE ----------
wall   = 3;
base_t = 4;

// ---------- PARÂMETROS DO ELO ----------
link_len = 95;       // comprimento total do elo frontal
link_w   = 18;       // largura do elo
link_t   = 6;        // espessura do elo

end_radius = link_w / 2;

hole_d = 4;          // furo de articulação
hole_margin = 10;    // distância do furo até a extremidade

rib_w = 7;           // largura da nervura central
rib_h = 4;           // altura extra da nervura

// ---------- MEDIDAS DERIVADAS ----------
servo_box_len = servo_len + 2 * wall;
servo_box_w   = servo_w + 2 * wall;
servo_box_h   = servo_h / 2 + base_t;

total_w = max(servo_box_w, link_w);
pocket_len = servo_len + 2 * clearance;
pocket_w   = servo_w + 2 * clearance;

// ======================================================
// MÓDULOS
// ======================================================

module rounded_link_2d(length, width) {
    hull() {
        translate([0, width / 2])
            circle(r = width / 2);

        translate([length, width / 2])
            circle(r = width / 2);
    }
}

module robotic_link() {
    translate([servo_box_len, (total_w - link_w) / 2, 0])
        linear_extrude(height = link_t)
            rounded_link_2d(link_len, link_w);
}

module central_rib() {
    translate([
        servo_box_len + 10,
        (total_w - rib_w) / 2,
        link_t
    ])
        cube([link_len - 20, rib_w, rib_h]);
}

module servo_mount() {
    difference() {
        // caixa de suporte do servo
        cube([servo_box_len, total_w, servo_box_h]);

        // cavidade de encaixe do servo
        translate([wall, (total_w - pocket_w) / 2, base_t])
            cube([pocket_len, pocket_w, servo_h]);
    }
}

module connector_neck() {
    // transição entre suporte do servo e elo
    translate([servo_box_len - 2, (total_w - link_w) / 2, 0])
        cube([8, link_w, link_t]);
}

// ======================================================
// PEÇA FINAL
// ======================================================

difference() {
    union() {
        servo_mount();
        connector_neck();
        robotic_link();
        central_rib();
    }

    // furo próximo ao suporte do servo
    translate([
        servo_box_len + hole_margin,
        total_w / 2,
        -1
    ])
        cylinder(h = link_t + rib_h + 2, d = hole_d);

    // furo central
    translate([
        servo_box_len + link_len / 2,
        total_w / 2,
        -1
    ])
        cylinder(h = link_t + rib_h + 2, d = hole_d);

    // furo na ponta do elo
    translate([
        servo_box_len + link_len - hole_margin,
        total_w / 2,
        -1
    ])
        cylinder(h = link_t + rib_h + 2, d = hole_d);
}