# ────────────────────────────────────────────────────
#  FFT, Power Spectrum and PSD Minimal Working Example
# ────────────────────────────────────────────────────

using FFTW
using Plots

fs = 400.0  # sampling frequency (Hz)
N = 2^5  # number of samples
t = (0:N-1) ./ fs  # time vector

# Generate a synthetic signal with two sine waves
x = 2 * sin.(100π * t) .- 0.5 * sin.(180π * t)  # composite signal: 50 Hz and 90 Hz components

# One-sided frequency axis and FFT
freqs = (0:N÷2-1) .* (fs / N)  # frequency resolution Δf = fs / N
X = abs.(fft(x)) ./ N  # normalize FFT
X[2:end-1] .*= 2.0  # double all bins except DC and nyquist

# Power Spectrum (V² for a sinusoid: 1/2 * A² )
Pow = X .^ 2 ./ 2

# Power Spectral Density (PSD) = Power / Frequency Resolution (V²/Hz)
PSD = Pow ./ (fs / N)

scatter(freqs, X, label="FFT", xlabel="Frequency (Hz)", ylabel="Magnitude", title="FFT · Power Spectrum · PSD", legend=:topright, markersize=3, color=:blue)
scatter!(freqs, Pow, label="Power Spectrum", markersize=3, color=:orange)
scatter!(freqs, DSP, label="Power Spectral Density", markersize=3, color=:green)
