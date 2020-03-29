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

% Last Modified by GUIDE v2.5 11-Nov-2019 22:45:21

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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    ImageFilter(hObject, handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    ImageFilter(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [I, path] = Display_Origin_Image(hObject, handles)
    path = '.\Data\';
    type = get(handles.listbox1, 'Value');
    iso = get(handles.listbox2, 'Value');
    switch type
        case 1
            path = [path 'outdoor_'];
        case 2
            path = [path 'room_'];
        case 3
            path = [path 'person_'];
    end
    switch iso
        case 1
            path = [path '200'];
        case 2
            path = [path '500'];
        case 3
            path = [path '1000'];
    end
    I = imread([path '.jpg']);
    I = rgb2gray(I);
    I = im2double(I);
    axes(handles.axes1);imshow(I);

function ImageFilter(hObject, handles)
    type = get(handles.listbox3, 'Value');
    Size = floor(get(handles.slider2, 'value'));
    switch type
        case 1
            set(handles.text5, 'String', '窗口大小：'+ string(Size));
        case 2
            set(handles.text5, 'String', '窗口大小：'+ string(Size));
        case 3
            set(handles.text5, 'String', '比较窗口大小：'+ string(2 * Size + 1));
    end
    fun1 = @(x) power(prod(x(:)),1/(Size * Size));
    h_arithmetic = ones(Size,Size)/(Size * Size);
    [I, path] = Display_Origin_Image(hObject, handles);
    switch type
        case 1
            image = imfilter(I,h_arithmetic);
            path = [path '_arithmetic_mean.jpg'];
        case 2
            image = nlfilter(I,[Size,Size],fun1);
            path = [path '_geometic_mean.jpg'];
        case 3
            image = imnlmfilt(I, 'SearchWindowSize', 45, 'ComparisonWindowSize', 2 * Size + 1);
            path = [path '_nlmean.jpg'];
    end
    imwrite(image, path);
    axes(handles.axes2);imshow(image);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Display_Origin_Image(hObject,handles);
    ImageFilter(hObject, handles);
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


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Display_Origin_Image(hObject,handles);
    ImageFilter(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
