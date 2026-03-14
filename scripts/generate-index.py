import json, os

items = []
devfiles_dir = "/devfiles"
for entry in os.scandir(devfiles_dir):
    if entry.is_dir():
        devfile_path = os.path.join(entry.path, "devfile.yaml")
        if os.path.exists(devfile_path):
            items.append({
                "displayName": entry.name,
                "links": {"v2": f"/devfiles/{entry.name}/devfile.yaml"}
            })

with open(os.path.join(devfiles_dir, "index.json"), "w") as f:
    json.dump(items, f)
