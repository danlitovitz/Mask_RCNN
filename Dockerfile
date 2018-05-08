FROM tensorflow/tensorflow:1.7.0-devel-gpu-py3

RUN git clone https://github.com/danlitovitz/Mask_RCNN.git
WORKDIR /root/Mask_RCNN
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

# graphical library for the ipython notebook demos
RUN apt-get update && apt-get install -y python-qt4

# install pycocotools for accessing MS-COCO
RUN git clone https://github.com/danlitovitz/coco.git
WORKDIR /root/Mask_RCNN/coco/PythonAPI
RUN python3 setup.py build_ext --inplace
RUN python3 setup.py build_ext install
RUN rm -rf build
WORKDIR /root/Mask_RCNN

CMD ["jupyter", "notebook", "--ip=*", "--allow-root", "--NotebookApp.token=''"]
EXPOSE 8888
