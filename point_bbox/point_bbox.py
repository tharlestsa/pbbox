import argparse
from pyproj import Transformer
from shapely.geometry import Point

parser = argparse.ArgumentParser(
    fromfile_prefix_chars='@',
    description='Create a bbox from point',
    epilog='Enjoy the program! :)'
)

parser.add_argument('--lon', type=float, help='Longitude of the point')

parser.add_argument('--lat', type=float, help='Latitude of the point')

parser.add_argument('--crs_from', type=str,  nargs='?', default='epsg:4326', help="Code of projection ex. 'epsg:4326'")

parser.add_argument('--crs_to', type=str,  nargs='?', default='epsg:900913', help="Code of projection ex. 'epsg:900913'")

parser.add_argument('--size', default=4000,  nargs='?', type=int, help='Size of the bbox in meters')


# Execute parse_args()
args = parser.parse_args()
# "epsg:4326", "epsg:900913"
crs_from = args.crs_from
crs_to = args.crs_to
transformer = Transformer.from_crs(crs_from, crs_to, always_xy=True)
x, y = transformer.transform(args.lon, args.lat)
buffer = Point(x, y).buffer(args.size)
bbox = buffer.bounds

print(f"{bbox[0]},{bbox[1]},{bbox[2]},{bbox[3]}")