# The following code will calculate the theorical predictions of the signals of the circuit

calc_pararel(n1, n2) = round((n1 * n2) / (n1 + n2), digits=4)
calc_omega(f) = round(2 * pi * f, digits=2)
calc_XL(L, f) = round(complex(0, 2 * pi * f * L), digits=4)
calc_XC(C, f) = round(complex(1, 0) / complex(0, 2 * pi * f * C), digits=4)
function calc_Z(r, f, L, C)
  round(complex(r, 0) + (calc_XL(L, f) - calc_XC(C, f)), digits=4)
end

calc_I(V, Z) = round(V / Z, digits=6)
calc_v_pico(vrms) = round(vrms * sqrt(2), digits=4)
init_polar(v_pico, phase) = v_pico * cis(deg2rad(phase))
to_polar(n) = round(abs(n), digits=6), round(rad2deg(angle(n)), digits=4)
polar_string(n) = "$(round(abs(n), digits=6))∠$(to_polar(n)[2])"
function current_divisor(I, z_current_side, z_other_size)
  round(I * z_other_size / (z_other_size + z_current_side), digits=6)
end
calc_vrms(v_pico) = round(v_pico / sqrt(2), digits=4)
freqcorte(R, C) = 1 / (R * C * 2 * pi)
# ganho(vo, vi) = 20 * log10(vo / vi)
ganho(R, C, f) = -20 * log10(h_calc(R, C, f))
h_calc(R, C, f) = 1 / abs(1 + (R * C * calc_omega(f) * 1im))

function print_all(L, C, R, f, v_pico, phase)
  println("Given:")
  println("L: ", round(L, digits=6), "H")
  println("C: ", C, "F")
  println("R: ", R, "Ω")
  println("f: ", f, "Hz")
  println("vpp: ", v_pico * 2, "V")
  println("v_pico: ", v_pico, "V")

  println("\nWe can calculate:")

  V = init_polar(v_pico, phase)
  Z = calc_Z(R, f, L, C)
  I = calc_I(V, Z)
  inductive_reactance = calc_XL(L, f)
  capacitive_reactance = calc_XC(C, f)
  impedance = calc_Z(R, f, L, C)
  omega = calc_omega(f)
  vrms = calc_vrms(v_pico)

  println("vrms: ", vrms, "V")
  println("omega: ", omega, " rad/s")
  println("calc_XL(): ", inductive_reactance, " = ", polar_string(inductive_reactance))
  println("calc_XC(): ", capacitive_reactance, " = ", polar_string(capacitive_reactance))
  println("calc_Z(): ", impedance, " = ", polar_string(impedance))
  println("I = V / Z = ", I, " = ", polar_string(I))
  println()

end

