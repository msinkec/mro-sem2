import json
import numpy as np
import matplotlib.pyplot as plt

def extract_element_from_json(obj, path):
    def extract(obj, path, idx, arr):
        key = path[idx]
        if idx + 1 < len(path):
            if isinstance(obj, dict):
                if key in obj.keys():
                    extract(obj.get(key), path, idx + 1, arr)
                else:
                    arr.append(None)
            elif isinstance(obj, list):
                if not obj:
                    arr.append(None)
                else:
                    for item in obj:
                        extract(item, path, idx, arr)
            else:
                arr.append(None)
        if idx + 1 == len(path):
            if isinstance(obj, list):
                if not obj:
                    arr.append(None)
                else:
                    for item in obj:
                        arr.append(item.get(key, None))
            elif isinstance(obj, dict):
                arr.append(obj.get(key, None))
            else:
                arr.append(None)
        return arr
    if isinstance(obj, dict):
        return extract(obj, path, 0, [])
    elif isinstance(obj, list):
        outer_arr = []
        for item in obj:
            outer_arr.append(extract(item, path, 0, []))
        return outer_arr

def draw_plot(module):
    n = len(module)
    for x in range(10):
        for i in range(1, n):
            val = 0
            for num, t in enumerate(module[i]['time']):
                if (t > x) and (t <= (x + 1)):
                    val += module[i]['value'][num]
            plt.bar(x, val)     # label='{}'.format('-'.join(module[i]['module'].split('.')[1:3]))
    plt.title('Packets in ethernet socket queue')
    plt.xlabel('time')
    plt.ylabel('number')
    plt.show()

def parse(filename):
    with open(filename, 'r') as json_file:
        data = json.load(json_file)
        for i in data:
            name = i
    extracted = extract_element_from_json(data, [name, "vectors"])
    lst = []
    for i in range(0, len(extracted[0])):
        if 'dataQueue' in extracted[0][i]['module'] and ('server' in extracted[0][i]['module'] or 'router' in extracted[0][i]['module']):
            if 'queueLength' in extracted[0][i]['name']:
                if len(set(extracted[0][i]['value'])) > 1:
                    lst.append(extracted[0][i])
    return lst

filename = 'porocilo/sem1-1.json'
lst = parse(filename)

draw_plot(lst)
