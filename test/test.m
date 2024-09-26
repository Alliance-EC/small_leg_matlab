syms x_B y_B x_d y_d l3 l2 phi2 phi3;

eqns = [x_B + l2 * cos(phi2) == x_d + l3 * cos(phi3);
        y_B + l2 * sin(phi2) == y_d + l3 * sin(phi3);
        ];
phi2 = solve(eqns, phi2, 'ReturnConditions', true);
