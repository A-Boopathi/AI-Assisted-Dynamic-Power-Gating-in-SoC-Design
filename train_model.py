import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, export_text
from sklearn.metrics import accuracy_score

# 1. Load the CSV
df = pd.read_csv(r"C:\Users\karthi\project_1\project_1.sim\sim_1\behav\xsim\activity_log_ml.csv")

# 2. Add useful features and clean
df["Idle_Counter"] = pd.to_numeric(df["Idle_Counter"], errors='coerce').fillna(0)
# Add noise to improve learning
df["Idle_Counter"] += np.random.normal(0, 0.3, len(df))

# 3. Define inputs and target
X = df[["Idle_Counter", "ALU_Active", "ALU_OP"]]
y = df["Power_Enable"]

# 4. Train/test split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 5. Train Decision Tree with better depth
clf = DecisionTreeClassifier(max_depth=6, min_samples_split=5, random_state=42)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)

# 6. Evaluate
accuracy = accuracy_score(y_test, y_pred)
print(f"\n🌳 Decision Tree Accuracy: {accuracy:.2f}")

# 7. Export tree logic
rules = export_text(clf, feature_names=["Idle_Counter", "ALU_Active", "ALU_OP"])
print("\n📘 Decision Tree Logic:\n", rules)
