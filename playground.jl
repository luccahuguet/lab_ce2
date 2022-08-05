
include("functions.jl")
println("running playground! \n")
using DataFrames


# function calc_Z_(r, f, L)
#   round(complex(r, 0) + (calc_XL(L, f)), digits=4)
# end

# r = 5000
# f = 60
# L = 6
# v = 1
# vrms = v / sqrt(2)

# # println(calc_Z_(r, f, L))
# # println(polar_string(calc_Z_(r, f, L)))
# # println(polar_string(119.28599999999999 + 119.91940865999999im))

# z_carga = calc_pararel(complex(r, 0), calc_XL(L, f))
# z_linha = calc_Z_(1000, 60, 470e-6)

# println("z_carga = ", z_carga, " = ", polar_string(z_carga))
# println("z_linha = ", z_linha, " = ", polar_string(z_linha))

# I = calc_I(init_polar(vrms, 0), z_carga)
# z_total = round(z_carga + z_linha, digits=6)
# pot_apar = round(z_total * (I^2), digits=6)


# println("I = V / Z = ", I, " = ", polar_string(I))
# println("pot_apar = ", pot_apar, " = ", polar_string(pot_apar))
# println("z_total = ", z_total, " = ", polar_string(z_total))

vi = 2 # vpp
R = 3700
C = 1e-9

fvec = cat(4400, 5e3:1e3:10e3, 20e3:10e3:100e3, 200e3:100e3:400e3, 440e3, dims=1)


# for el in fvec
#   println(el)
# end

f_corte = freqcorte(R, C)

println("freq de corte =", f_corte)

h = h_calc(R, C, fvec[1])
hvec = h_calc.(R, C, fvec)
ganhovec = ganho.(R, C, fvec)

println(" f \t\t\t|\t\t\tH(jw)\t\t\t|\t\t\tGanho")

for (idx, each_h) in enumerate(hvec)
  println(fvec[idx], "\t|\t", each_h, "\t|\t", ganhovec[idx])
  # println(" | Ganho[", fvec[idx], "] = ", ganhovec[idx])
end
# for (idx, each_h) in enumerate(hvec)
#   print("H[", fvec[idx], "] = ", each_h)
#   println(" | Ganho[", fvec[idx], "] = ", ganhovec[idx])
# end

# for (idx, each_ganho) in enumerate(ganhovec)
#   # println("Ganho[", fvec[idx], "] = ", each_ganho)
#   println(each_ganho)
# end
# println(hvec)

img = R * C * calc_omega(fvec[1]) * 1im - 1
