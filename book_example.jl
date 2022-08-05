

include("functions.jl")
println("running book example! \n")

L = 20 * 1e-3
C = 50 * 1e-6
f = 60
R = 25
Z = calc_Z(R, f, L, C)
v = 50
V = init_polar(v, 30)

inductive_reactance = calc_XL(L, f)
println("calc_XL(20 * 1e-3, 60): ", inductive_reactance, " = ", polar_string(inductive_reactance))

capacitive_reactance = calc_XC(C, f)
println("calc_XC(50 * 1e-6, 60): ", capacitive_reactance, " = ", polar_string(capacitive_reactance))

impedance = calc_Z(R, f, L, C)
println("calc_Z(25, 60, 20 * 1e-3, 50 * 1e-6): ", impedance, " = ", polar_string(impedance))

I = calc_I(V, Z)
println("I = V / Z = ", I, " = ", polar_string(I))