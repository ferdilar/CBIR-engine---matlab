function varargout = tubesipc(varargin)
% TUBESIPC MATLAB code for tubesipc.fig
%      TUBESIPC, by itself, creates a new TUBESIPC or raises the existing
%      singleton*.
%
%      H = TUBESIPC returns the handle to a new TUBESIPC or the handle to
%      the existing singleton*.
%
%      TUBESIPC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUBESIPC.M with the given input arguments.
%
%      TUBESIPC('Property','Value',...) creates a new TUBESIPC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tubesipc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tubesipc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tubesipc

% Last Modified by GUIDE v2.5 04-Jan-2016 19:49:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tubesipc_OpeningFcn, ...
                   'gui_OutputFcn',  @tubesipc_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before tubesipc is made visible.
function tubesipc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tubesipc (see VARARGIN)

% Choose default command line output for tubesipc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tubesipc wait for user response (see UIRESUME)
% uiwait(handles.figure1);
run('C:\Users\Ferdila Rahmi\Documents\MATLAB\vlfeat-0.9.20\toolbox\vl_setup.m');
%addpath('C:\Users\Ferdila Rahmi\Documents\MATLAB\');
%addpath('D:\7\IPC\tugas3\pakai\');
%run('vlfeat-0.9.20\toolbox\vl_setup.m');

% --- Outputs from this function are returned to the command line.
function varargout = tubesipc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pilih_image.
function pilih_image_Callback(hObject, eventdata, handles)
% hObject    handle to pilih_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% load file
global tes_img
[path,user_cance]=imgetfile();
if user_cance
    msgbox(sprintf('Error'),'Error','Error');
    return
end
tes_img=imread(path);
set(handles.text13,'string',path);
axes(handles.axes1);
imshow(tes_img);

% --- Executes on button press in button_hog.
function button_hog_Callback(hObject, eventdata, handles)
% hObject    handle to button_hog (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msg='Loading HOG ...'
set(handles.msg,'string','Loading HOG ...');
addpath('D:\7\IPC\tugas3\pakai\');
addpath('D:\7\IPC\tugas3\');
files=dir('D:\7\IPC\tugas3\pakai\*.jpg');
n=numel(files);
for i=1:n
    img=imread(files(i).name);
	img1=imresize(img,[15,10]);
    val_hog=vl_hog(single(rgb2gray(img1)),2);%mengeluarkan data vektor
	db_hog(i,:)=val_hog(:);
	img_hog=vl_hog('render',val_hog);%mengeluarkan image
	db_img_hog(i,:)=img_hog(:);
end
global tes_img
tes_img1=imresize(tes_img,[15,10]);
tes_data_hog=vl_hog(single(rgb2gray(tes_img1)),2);
tes_hog(1,:)=tes_data_hog(:);
tes_data_hog_img=vl_hog('render',tes_data_hog);


idx_min(1:10)=0;
for j=1:10
	min=1000;
	idx=1;
	for i=1:n
		if(i~=idx_min(1)) && (i~=idx_min(2)) && (i~=idx_min(3)) && (i~=idx_min(4)) && (i~=idx_min(5)) &&(i~=idx_min(6)) && (i~=idx_min(7)) && (i~=idx_min(8)) && (i~=idx_min(9)) && (i~=idx_min(10))
			tempD=sqrt(sum((db_hog(i,:)-tes_hog(1,:)).^2));
			if(tempD<=min)
				idx=i;
				min=tempD;
			end
		end
	end
	idx_min(j)=idx;
end

imgRes1=imread(files(idx_min(1)).name);
axes(handles.axes3);
imshow(imgRes1);

imgRes2=imread(files(idx_min(2)).name);
axes(handles.axes4);
imshow(imgRes2);

imgRes3=imread(files(idx_min(3)).name);
axes(handles.axes5);
imshow(imgRes3);

imgRes4=imread(files(idx_min(4)).name);
axes(handles.axes6);
imshow(imgRes4);

imgRes5=imread(files(idx_min(5)).name);
axes(handles.axes7);
imshow(imgRes5);

imgRes6=imread(files(idx_min(6)).name);
axes(handles.axes8);
imshow(imgRes6);

imgRes7=imread(files(idx_min(7)).name);
axes(handles.axes9);
imshow(imgRes7);

imgRes8=imread(files(idx_min(8)).name);
axes(handles.axes10);
imshow(imgRes8);

imgRes9=imread(files(idx_min(9)).name);
axes(handles.axes11);
imshow(imgRes9);

imgRes10=imread(files(idx_min(10)).name);
axes(handles.axes12);
imshow(imgRes10);

set(handles.text3,'string',files(idx_min(1)).name);
set(handles.text4,'string',files(idx_min(2)).name);
set(handles.text5,'string',files(idx_min(3)).name);
set(handles.text6,'string',files(idx_min(4)).name);
set(handles.text7,'string',files(idx_min(5)).name);
set(handles.text8,'string',files(idx_min(6)).name);
set(handles.text9,'string',files(idx_min(7)).name);
set(handles.text10,'string',files(idx_min(8)).name);
set(handles.text11,'string',files(idx_min(9)).name);
set(handles.text12,'string',files(idx_min(10)).name);

set(handles.msg,'string','Selesai Pencarian HOG');
msg='Selesai Pencarian HOG'

% --- Executes on button press in button_mser.
function button_mser_Callback(hObject, eventdata, handles)
% hObject    handle to button_mser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msg='Loading MSER ...'
set(handles.msg,'string','Loading MSER ...');
addpath('D:\7\IPC\tugas3\pakai\');
addpath('D:\7\IPC\tugas3\');
files=dir('D:\7\IPC\tugas3\pakai\*.jpg');
n=numel(files);

for i=1:n
    img=imread(files(i).name);
	img1=imresize(img,[15,10]);
    val_mser=vl_mser(rgb2gray(img1));%panjang vektor berbeda error disimpan ke db
	%length(val_mser)
	%whos val_mser
	db_mser(i,:)=length(val_mser);%akurasi buruk
end

global tes_img
tes_img1=imresize(tes_img,[15,10]);
tes_data_mser=vl_mser(rgb2gray(tes_img1));
tes_mser(1,:)=length(tes_data_mser);

idx_min(1:10)=0;
for j=1:10
	min=1000;
	idx=1;
	for i=1:n
		if(i~=idx_min(1)) && (i~=idx_min(2)) && (i~=idx_min(3)) && (i~=idx_min(4)) && (i~=idx_min(5)) &&(i~=idx_min(6)) && (i~=idx_min(7)) && (i~=idx_min(8)) && (i~=idx_min(9)) && (i~=idx_min(10))
			tempD=abs(db_mser(i,:)-tes_mser(1,:));
			if(tempD<=min)
				idx=i;
				min=tempD;
			end
		end
	end
	idx_min(j)=idx;
end

imgRes1=imread(files(idx_min(1)).name);
axes(handles.axes3);
imshow(imgRes1);

imgRes2=imread(files(idx_min(2)).name);
axes(handles.axes4);
imshow(imgRes2);

imgRes3=imread(files(idx_min(3)).name);
axes(handles.axes5);
imshow(imgRes3);

imgRes4=imread(files(idx_min(4)).name);
axes(handles.axes6);
imshow(imgRes4);

imgRes5=imread(files(idx_min(5)).name);
axes(handles.axes7);
imshow(imgRes5);

imgRes6=imread(files(idx_min(6)).name);
axes(handles.axes8);
imshow(imgRes6);

imgRes7=imread(files(idx_min(7)).name);
axes(handles.axes9);
imshow(imgRes7);

imgRes8=imread(files(idx_min(8)).name);
axes(handles.axes10);
imshow(imgRes8);

imgRes9=imread(files(idx_min(9)).name);
axes(handles.axes11);
imshow(imgRes9);

set(handles.text3,'string',files(idx_min(1)).name);
set(handles.text4,'string',files(idx_min(2)).name);
set(handles.text5,'string',files(idx_min(3)).name);
set(handles.text6,'string',files(idx_min(4)).name);
set(handles.text7,'string',files(idx_min(5)).name);
set(handles.text8,'string',files(idx_min(6)).name);
set(handles.text9,'string',files(idx_min(7)).name);
set(handles.text10,'string',files(idx_min(8)).name);
set(handles.text11,'string',files(idx_min(9)).name);
set(handles.text12,'string',files(idx_min(10)).name);

imgRes10=imread(files(idx_min(10)).name);
axes(handles.axes12);
imshow(imgRes10);
set(handles.msg,'string','Selesai Pencarian MSER');
msg='Selesai Pencarian MSER'

% --- Executes on button press in button_glcm.
function button_glcm_Callback(hObject, eventdata, handles)
% hObject    handle to button_glcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msg='Loading GLCM ...'
set(handles.msg,'string','Loading GLCM ...');
addpath('D:\7\IPC\tugas3\pakai\');
addpath('D:\7\IPC\tugas3\');
files=dir('D:\7\IPC\tugas3\pakai\*.jpg');
n=numel(files);

for i=1:n
    img=imread(files(i).name);
	img1=imresize(img,[15,10]);
    val_glcm=graycomatrix(rgb2gray(img1),'Offset',[2 0;0 2]);
	db_glcm(i,:)=val_glcm(:);
end
global tes_img
tes_img1=imresize(tes_img,[15,10]);
tes_data_glcm=graycomatrix(rgb2gray(tes_img1),'Offset',[2 0;0 2]);
tes_glcm(1,:)=tes_data_glcm(:);

idx_min(1:10)=0;
for j=1:10
	min=1000;
	idx=1;
	for i=1:n
		if(i~=idx_min(1)) && (i~=idx_min(2)) && (i~=idx_min(3)) && (i~=idx_min(4)) && (i~=idx_min(5)) &&(i~=idx_min(6)) && (i~=idx_min(7)) && (i~=idx_min(8)) && (i~=idx_min(9)) && (i~=idx_min(10))
			tempD=sqrt(sum((db_glcm(i,:)-tes_glcm(1,:)).^2));
			if(tempD<=min)
				idx=i;
				min=tempD;
			end
		end
	end
	idx_min(j)=idx;
end

imgRes1=imread(files(idx_min(1)).name);
axes(handles.axes3);
imshow(imgRes1);

imgRes2=imread(files(idx_min(2)).name);
axes(handles.axes4);
imshow(imgRes2);

imgRes3=imread(files(idx_min(3)).name);
axes(handles.axes5);
imshow(imgRes3);

imgRes4=imread(files(idx_min(4)).name);
axes(handles.axes6);
imshow(imgRes4);

imgRes5=imread(files(idx_min(5)).name);
axes(handles.axes7);
imshow(imgRes5);

imgRes6=imread(files(idx_min(6)).name);
axes(handles.axes8);
imshow(imgRes6);

imgRes7=imread(files(idx_min(7)).name);
axes(handles.axes9);
imshow(imgRes7);

imgRes8=imread(files(idx_min(8)).name);
axes(handles.axes10);
imshow(imgRes8);

imgRes9=imread(files(idx_min(9)).name);
axes(handles.axes11);
imshow(imgRes9);

imgRes10=imread(files(idx_min(10)).name);
axes(handles.axes12);
imshow(imgRes10);

set(handles.text3,'string',files(idx_min(1)).name);
set(handles.text4,'string',files(idx_min(2)).name);
set(handles.text5,'string',files(idx_min(3)).name);
set(handles.text6,'string',files(idx_min(4)).name);
set(handles.text7,'string',files(idx_min(5)).name);
set(handles.text8,'string',files(idx_min(6)).name);
set(handles.text9,'string',files(idx_min(7)).name);
set(handles.text10,'string',files(idx_min(8)).name);
set(handles.text11,'string',files(idx_min(9)).name);
set(handles.text12,'string',files(idx_min(10)).name);

set(handles.msg,'string','Selesai Pencarian GLCM');
msg='Selesai Pencarian GLCM'
