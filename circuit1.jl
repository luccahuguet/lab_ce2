

include("functions.jl")
println("running circuit 1! \n")

L = 33 * 1e-6
C = 0.1 * 1e-6
f = 500
R = 1000
vpp = 2
v_pico = vpp / 2
src_phase = 0
V = init_polar(v_pico, src_phase)

omega = calc_omega(f)
println("omega: ", omega, " rad/s")

inductive_reactance = calc_XL(L, f)
println("calc_XL(): ", inductive_reactance, " = ", polar_string(inductive_reactance))

capacitive_reactance = calc_XC(C, f)
println("calc_XC(): ", capacitive_reactance, " = ", polar_string(capacitive_reactance))

Z = calc_Z(R, f, L, C)
println("calc_Z(): ", Z, " = ", polar_string(Z))

I = calc_I(V, Z)
println("I = V / Z = ", I, " = ", polar_string(I))

V = round(complex(R, 0) * I, digits=6)
# prints V with one digits after the decimal point
println("V = R * I = ", V, " = ", polar_string(V))

print_all(L, C, R, f, v_pico, src_phase)