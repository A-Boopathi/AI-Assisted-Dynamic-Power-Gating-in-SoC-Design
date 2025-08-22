import pandas as pd

# Load activity log
df = pd.read_csv(r"C:\Users\karthi\project_1\project_1.sim\sim_1\behav\xsim\activity_log_ml.csv")

# Count total cycles and gated cycles
total_cycles = len(df)
off_cycles = df[df["Power_Enable"] == 0].shape[0]
on_cycles = df[df["Power_Enable"] == 1].shape[0]

# % of time power gating was active
percent_gated = (off_cycles / total_cycles) * 100

# Assume idle leakage power (you can change this)
idle_power_uw = 100  # µW

# Estimate saved power
P_saved = (off_cycles / total_cycles) * idle_power_uw  # in µW

# Print results
print(f"🔁 Total cycles: {total_cycles}")
print(f"🔌 Power gated cycles: {off_cycles}")
print(f"⚡ Power ON cycles: {on_cycles}")
print(f"⏳ % Time ALU gated: {percent_gated:.2f}%")
print(f"💡 Estimated Power Saved: {P_saved:.2f} µW")

