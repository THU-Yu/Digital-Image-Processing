function varargout = Question1(varargin)
% QUESTION1 MATLAB code for Question1.fig
%      QUESTION1, by itself, creates a new QUESTION1 or raises the existing
%      singleton*.
%
%      H = QUESTION1 returns the handle to a new QUESTION1 or the handle to
%      the existing singleton*.
%
%      QUESTION1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUESTION1.M with the given input arguments.
%
%      QUESTION1('Property','Value',...) creates a new QUESTION1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Question1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Question1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Question1

% Last Modified by GUIDE v2.5 17-Nov-2019 20:09:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Question1_OpeningFcn, ...
                   'gui_OutputFcn',  @Question1_OutputFcn, ...
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


% --- Executes just before Question1 is made visible.
function Question1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Question1 (see VARARGIN)

% Choose default command line output for Question1
handles.output = hObject;
DisplayColor(hObject, handles);
DisplayOriginImage(hObject, handles);
DisplayNewImage(hObject, handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Question1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Question1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function DisplayColor(hObject, handles)
    hsv1 = get(handles.hsv1, 'value');
    hsv2 = get(handles.hsv2, 'value');
    h = 50;
    w = 50;
    color = ones(h, w, 3);
    color(:, :, 1) = hsv1 * ones(h, w);
    color(:, :, 2) = hsv2 * ones(h, w);
    axes(handles.axes3);
    imshow(hsv2rgb(color));

function DisplayOriginImage(hObject, handles)
    type = get(handles.listbox1, 'value');
    type = string(type);
    path = '.\Data\'+type+'.jpg';
    I = imread(path);
    axes(handles.axes1);
    imshow(I);
    
function DisplayNewImage(hObject, handles)
    type = get(handles.listbox1, 'value');
    hsv1 = get(handles.hsv1, 'value');
    hsv2 = get(handles.hsv2, 'value');
    s = string(type);
    path = '.\Data\'+s+'.jpg';
    I = imread(path);
    I = im2double(I);
    a_point = [87 312;209 514;143 377;491 791;1225 2493;218 581;86 620;84 242];
    rect = [11 189 138 464;10 312 244 682;9 316 195 623;152 968 602 1685;1 2166 1665 3470;1 459 390 775;26 410 300 784;14 185 158 405];
    R = ((50/255)^(type < 4)) * ((70 / 255) ^ (type < 6 & type > 3)) * ((100 / 255) ^ (type > 5)); 
    a = [I(a_point(type, 2), a_point(type, 1), 1) I(a_point(type, 2), a_point(type, 1), 2) I(a_point(type, 2), a_point(type, 1), 3)];
    D = (I(:,:,1)-a(1)).^2+(I(:,:,2)-a(2)).^2+(I(:,:,3)-a(3)).^2;
    mask = D<=R*R;
    roi = false(size(mask));
    roi(rect(type, 3):rect(type, 4), rect(type, 1):rect(type, 2)) = 1;
    mask = mask & roi;
    hsv_I = rgb2hsv(I);
    hsv = hsv_I(:,:,1);
    hsv(mask>0) = hsv1;
    hsv_I(:,:,1) = hsv;
    hsv = hsv_I(:,:,2);
    hsv(mask>0) = hsv2;
    hsv_I(:,:,2) = hsv;
    NewI = hsv2rgb(hsv_I);
    axes(handles.axes2);
    imshow(NewI);
% --- Executes on slider movement.
function hsv1_Callback(hObject, eventdata, handles)
% hObject    handle to hsv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    DisplayColor(hObject, handles);
    DisplayOriginImage(hObject, handles);
    DisplayNewImage(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function hsv1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hsv1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function hsv2_Callback(hObject, eventdata, handles)
% hObject    handle to hsv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    DisplayColor(hObject, handles);
    DisplayOriginImage(hObject, handles);
    DisplayNewImage(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function hsv2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hsv2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    DisplayOriginImage(hObject, handles);
    DisplayNewImage(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
