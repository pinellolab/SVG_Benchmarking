"""Download spatial transcriptomics data."""

import os
from urllib.request import urlopen, Request
import wget

BASE_URL = "https://gene.ai.tencent.com/SpatialOmics/api/download_data"

# 2750
for i in range(2750):
    url = f"{BASE_URL}/{i+1}"
    meta_data = urlopen(Request(url)).info()
    filename = meta_data.get_filename()
    protocol = filename.split("_")[0]

    if not os.path.exists(f"../{protocol}"):
        os.mkdir(f"../{protocol}")

    if not os.path.exists(f"../{protocol}/{filename}"): 
        print(f"Downloading {meta_data.get_filename()}...\n")
        wget.download(url=f"{BASE_URL}/{i+1}", out=f"../{protocol}")
