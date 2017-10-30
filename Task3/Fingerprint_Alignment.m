function varargout = Fingerprint_Alignment(varargin)
% FINGERPRINT_ALIGNMENT MATLAB code for Fingerprint_Alignment.fig
%      FINGERPRINT_ALIGNMENT, by itself, creates a new FINGERPRINT_ALIGNMENT or raises the existing
%      singleton*.
%
%      H = FINGERPRINT_ALIGNMENT returns the handle to a new FINGERPRINT_ALIGNMENT or the handle to
%      the existing singleton*.
%
%      FINGERPRINT_ALIGNMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERPRINT_ALIGNMENT.M with the given input arguments.
%
%      FINGERPRINT_ALIGNMENT('Property','Value',...) creates a new FINGERPRINT_ALIGNMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fingerprint_Alignment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fingerprint_Alignment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fingerprint_Alignment

% Last Modified by GUIDE v2.5 28-Oct-2017 01:56:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fingerprint_Alignment_OpeningFcn, ...
                   'gui_OutputFcn',  @Fingerprint_Alignment_OutputFcn, ...
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


% --- Executes just before Fingerprint_Alignment is made visible.
function Fingerprint_Alignment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fingerprint_Alignment (see VARARGIN)

% Choose default command line output for Fingerprint_Alignment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fingerprint_Alignment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fingerprint_Alignment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnOpenImage.
function btnOpenImage_Callback(hObject, eventdata, handles)

handles.Image = imread('axis.jpg');
axes(handles.axes2);
imshow(handles.Image);

ImageName = get(handles.txtOpenImage , 'string')
handles.Image = imread(char(ImageName));
axes(handles.axes1);
imshow(handles.Image);


guidata(hObject, handles);
set(handles.lblx ,'string','x loc');
set(handles.lbly ,'string','y loc');
set(handles.Num ,'string',0);


global cnt
global points
cnt = 1;
points= ones(3,8);


% --- Executes on button press in btnExtractLandmarks.
function btnExtractLandmarks_Callback(hObject, eventdata, handles)
% hObject    handle to btnExtractLandmarks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
txtVal = get(handles.txtShortEdge, 'String');
Length = str2num(txtVal);
[H W L] = size(handles.Image);
Image = handles.Image;
if(L==1)
 [Endpoints,ShortEdges]=ExtractLandmarks(Image, Length);
else
 Image = ImageThresholding(rgb2gray(handles.Result));
 [Endpoints,ShortEdges]=ExtractLandmarks(Image, Length);
end
 Img=cat(3,Image,Image,Image);
 
 [H W L] = size(Endpoints) 
 for y=2 : H
     N=Endpoints(y,1);
     M=Endpoints(y,2);
     Img(N:2,M:2,1)=255;
     Img(N:N+2,M:M+2,2)=0;
     Img(N:N+2,M:M+2,3)=0;
 end
[H W] = size(ShortEdges);
for i=1:H
    PrevI = ShortEdges(i,1);
    PrevJ = ShortEdges(i,2);
    CurrI = ShortEdges(i,1);
    CurrJ = ShortEdges(i,2);
    NextI = ShortEdges(i,1);
    NextJ = ShortEdges(i,2);
    Img(CurrI:CurrI+1,CurrJ:CurrJ+1,1) = 0;
    Img(CurrI:CurrI+1,CurrJ:CurrJ+1,2) = 0;
    Img(CurrI:1,CurrJ:1,3) = 255;
    while ~(NextI == ShortEdges(i,3) && NextJ == ShortEdges(i,4))
        [NextCoordinates C] = GetNextCoordinates(Image , [CurrI CurrJ] , [PrevI PrevJ]);
        NextI = NextCoordinates(1,1);
        NextJ = NextCoordinates(1,2);
        Img(NextI:NextI+1,NextJ:NextJ+1,1) = 0;
        Img(NextI:NextI+1,NextJ:NextJ+1,2) = 0;
        Img(NextI:1,NextJ:1,3) = 255;
        PrevI = CurrI;
        PrevJ = CurrJ; 
        CurrI = NextI;
        CurrJ = NextJ;
    end
end
 
handles.Result=Img;
axes(handles.axes2);
imshow(handles.Result);

% Save the handles structure.
guidata(hObject, handles);
     


function txtShortEdge_Callback(hObject, eventdata, handles)
% hObject    handle to txtShortEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtShortEdge as text
%        str2double(get(hObject,'String')) returns contents of txtShortEdge as a double


% --- Executes during object creation, after setting all properties.
function txtShortEdge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtShortEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtOpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to txtOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOpenImage as text
%        str2double(get(hObject,'String')) returns contents of txtOpenImage as a double


% --- Executes during object creation, after setting all properties.
function txtOpenImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWidth_Callback(hObject, eventdata, handles)
% hObject    handle to txtWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWidth as text
%        str2double(get(hObject,'String')) returns contents of txtWidth as a double


% --- Executes during object creation, after setting all properties.
function txtWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtHeight_Callback(hObject, eventdata, handles)
% hObject    handle to txtHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtHeight as text
%        str2double(get(hObject,'String')) returns contents of txtHeight as a double


% --- Executes during object creation, after setting all properties.
function txtHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnApply.
function btnApply_Callback(hObject, eventdata, handles)
% hObject    handle to btnApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
txtWidth = get(handles.txtWidth, 'String');
width = str2num(txtWidth);
txtHeight = get(handles.txtHeight, 'String');
height = str2num(txtHeight);
[handles.Result, Q] = Align(handles.Image, width, height);
axes(handles.axes2);
imshow(handles.Result);
% Save the handles structure.
guidata(hObject, handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cnt 
global points
Cp = get(gca,'currentpoint');
col = round(Cp(1,1))+1;
row = round(Cp(1,2))+1;
points(:,cnt(1))= [row;col;1];
set(handles.lblx ,'string',row);
set(handles.lbly ,'string',col);
set(handles.Num ,'string',cnt);
cnt = cnt + 1;
disp(points);
if(cnt==9)
    handles.Result= Warp(handles.Image , points(:,1:4) , points(:,5:8));
    axes(handles.axes2);
    imshow(handles.Result);
    guidata(hObject, handles);
end
    


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
