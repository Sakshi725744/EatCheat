from flask import Flask
from flask_restful import Api, Resource, reqparse
import urllib
import numpy as np
#import barcode_scanner
import model_exec

app = Flask(__name__)
api = Api(app)

image_args = reqparse.RequestParser()
image_args.add_argument("url", type=str, help="Path of the image is required", required=True)

class Barcode(Resource):
    def get(self, img_sno):
        args = image_args.parse_args()
        img_url = args['url']
        #img_path = urllib.request.urlretrieve(img_url, 'image'+str(img_sno)+'.jpg')[0]
        '''
        listres = barcode_scanner.main(img)
        '''
        #retimg = np.asarray(img).tolist()
        return {'result': img_url}

class MLmodel(Resource):
    def get(self, img_sno):
        args = image_args.parse_args()
        img_url = args['url']
        img_path = urllib.request.urlretrieve(img_url, 'image'+str(img_sno)+'.jpg')[0]
        name, exp = model_exec.main(img_path)
        return {'name':name, 'expiry':exp}

api.add_resource(Barcode, "/barcode/<int:img_sno>")
api.add_resource(MLmodel, "/mlmodel/<int:img_sno>")

if __name__ == "__main__":
    app.run(debug=False)