

include("functions.jl")
println("running circuit 2! \n")

# base values
L = 33 * 1e-6
C = 0.1 * 1e-6
phase = 0
R1 = 2200
R2 = 1000

# Fonte 1: 2VRMS, 3KHz; Fonte 2: 5VRMS, 10KHz.
# Considere R1 = 2,2XY R2 = 1,0XY

# Case 1:
vrms = 2
f = 3000
v_pico = calc_v_pico(vrms)
V = init_polar(vrms, phase)


println("Case 1:")
omega = calc_omega(f)
println("omega: ", omega, " rad/s")

XL = calc_XL(L, f)
println("calc_XL(): ", XL, " = ", polar_string(XL))

XC = calc_XC(C, f)
println("calc_XC(): ", XC, " = ", polar_string(XC))


series1 = -XC + XL
zreq1 = round(calc_pararel(R2, series1), digits=4)
zreq = round(zreq1 + R1, digits=4)

println("zreq1: ", zreq1, "Ω", " = ", polar_string(zreq1))
println("zreq: ", zreq, "Ω", " = ", polar_string(zreq))

I = calc_I(V, zreq)
println("I = V / Z = ", I, " = ", polar_string(I))

r_other_side = R2
r_current_side = -XC + XL

I_current_side = current_divisor(I, r_current_side, r_other_side)
println("I (IC) = ", I_current_side, " = ", polar_string(I_current_side))

v1 = XC * I_current_side
println("V (IC) = ", v1, " = ", polar_string(v1))

println()

# print_all(L, C, req, f, v_pico, phase)

# Case 2:
vrms = 5
f = 10000
series = R2 - C + L
req = calc_pararel(R1, series)
v_pico = calc_v_pico(vrms)
V = init_polar(vrms, phase)
Z = calc_Z(req, f, L, C)

println("Case 2:")
omega = calc_omega(f)
println("omega: ", omega, " rad/s")

XL = calc_XL(L, f)
println("calc_XL(): ", XL, " = ", polar_string(XL))

XC = calc_XC(C, f)
println("calc_XC(): ", XC, " = ", polar_string(XC))


series1 = -XC + XL
zreq1 = round(calc_pararel(R1, series1), digits=4)
zreq = round(zreq1 + R2, digits=4)

println("zreq1: ", zreq1, "Ω", " = ", polar_string(zreq1))
println("zreq: ", zreq, "Ω", " = ", polar_string(zreq))
I = calc_I(V, zreq)
println("I = V / Z = ", I, " = ", polar_string(I))

r_other_side = R1
r_current_side = -XC + XL

I_current_side = current_divisor(I, r_current_side, r_other_side)
println("I (IC) = ", I_current_side, " = ", polar_string(I_current_side))

v2 = XC * I_current_side
println("V (IC) = ", v2, " = ", polar_string(v2))


new_vrms = round(sqrt(abs(v1)^2 + abs(v2)^2), digits=4)
println("Vrms = ", new_vrms)