def quick_sort(entry, first, last):
    if first < last:
        pivot = partition(entry, first, last)

        quick_sort(entry, first, pivot - 1)
        quick_sort(entry, pivot + 1, last)

    return entry


def partition(entry, first, last):
    pivot_value = entry[first]

    left = right = first + 1

    while right <= last:
        if entry[right] < pivot_value:
            entry[left], entry[right] = entry[right], entry[left]
            left += 1

        right += 1

    entry[first], entry[left - 1] = entry[left - 1], entry[first]
    print(last - first)
    return left - 1


t1 = [int(line.rstrip('\n')) for line in open('./t1.txt')]
print(quick_sort(t1, 0, len(t1) - 1)) 
