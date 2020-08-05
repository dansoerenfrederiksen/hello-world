function varargout = BasicModel3(varargin)
% BASICMODEL3 MATLAB code for BasicModel3.fig
%      BASICMODEL3, by itself, creates a new BASICMODEL3 or raises the existing
%      singleton*.
%
%      H = BASICMODEL3 returns the handle to a new BASICMODEL3 or the handle to
%      the existing singleton*.
%
%      BASICMODEL3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASICMODEL3.M with the given input arguments.
%
%      BASICMODEL3('Property','Value',...) creates a new BASICMODEL3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BasicModel3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BasicModel3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BasicModel3

% Last Modified by GUIDE v2.5 14-Sep-2012 09:21:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BasicModel3_OpeningFcn, ...
                   'gui_OutputFcn',  @BasicModel3_OutputFcn, ...
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


% --- Executes just before BasicModel3 is made visible.
function BasicModel3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BasicModel3 (see VARARGIN)

% Choose default command line output for BasicModel3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.ParkNames=turbine_getMBMParkNames;
% blacklist training rig
handles.ParkNames(strcmpi(handles.ParkNames,'2,3MkII training rig, Houston'))=[];
set(handles.ListTrainPark,'String',handles.ParkNames)
set(handles.ListUsePark,'String',handles.ParkNames)
Turbines=turbine_getMBMId('parkname',handles.ParkNames{1});
set(handles.ListTrainTurbine,'String',num2str(Turbines'))
set(handles.ListUseTurbine,'String',['    all'; num2str(Turbines')])
set(handles.EditTrainTimeFrom,'String',datestr(datenum(clock)-90,31))
set(handles.EditTrainTimeTo,'String',datestr(datenum(clock),31))
set(handles.EditUseTimeFrom,'String',datestr(datenum(clock)-90,31))
set(handles.EditUseTimeTo,'String',datestr(datenum(clock),31))
AllMyModels={'neural'};
handles.MyModels=AllMyModels;
set(handles.ListTrainModelType,'string',handles.MyModels)
handles.MyTDIs=mhf.tdiShortName(wfdb_tdi);
handles.MyTDIs=sort(strtrim(mat2cell(handles.MyTDIs,ones(size(handles.MyTDIs,1),1))));
set(handles.ListTrainFeatures,'string',handles.MyTDIs)
set(handles.ListUseFeatures,'string',handles.MyTDIs)
set(handles.Load,'BackgroundColor',[0 1 0])
set(handles.Delete,'BackgroundColor',[0 1 0])
set(handles.ButtonSave,'backgroundcolor',[1 0 0])
set(handles.UseButton,'backgroundcolor',[1 0 0])
set(handles.TrainButton,'backgroundcolor',[1 0 0])


guidata(hObject, handles);
% UIWAIT makes BasicModel3 wait for user response (see UIRESUME)
% uiwait(handles.BasicModel3);


% --- Outputs from this function are returned to the command line.
function varargout = BasicModel3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in ListTrainPark.
function ListTrainPark_Callback(hObject, eventdata, handles)
% hObject    handle to ListTrainPark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListTrainPark contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListTrainPark
MyPark=handles.ParkNames(get(handles.ListTrainPark,'Value'));
set(handles.ListTrainTurbine,'String',num2str(sort(turbine_getId(cell2mat(MyPark))')))
set(handles.ListTrainTurbine,'Value',1)

% --- Executes during object creation, after setting all properties.
function ListTrainPark_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListTrainPark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListTrainTurbine.
function ListTrainTurbine_Callback(hObject, eventdata, handles)
% hObject    handle to ListTrainTurbine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListTrainTurbine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListTrainTurbine


% --- Executes during object creation, after setting all properties.
function ListTrainTurbine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListTrainTurbine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditTrainTimeFrom_Callback(hObject, eventdata, handles)
% hObject    handle to EditTrainTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditTrainTimeFrom as text
%        str2double(get(hObject,'String')) returns contents of EditTrainTimeFrom as a double


% --- Executes during object creation, after setting all properties.
function EditTrainTimeFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditTrainTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditTrainTimeTo_Callback(hObject, eventdata, handles)
% hObject    handle to EditTrainTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditTrainTimeFrom as text
%        str2double(get(hObject,'String')) returns contents of EditTrainTimeFrom as a double


% --- Executes during object creation, after setting all properties.
function EditTrainTimeTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditTrainTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox8.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox8


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox9.
function listbox9_Callback(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox9


% --- Executes during object creation, after setting all properties.
function listbox9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListTrainModelType.
function ListTrainModelType_Callback(hObject, eventdata, handles)
% hObject    handle to ListTrainModelType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListTrainModelType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListTrainModelType


% --- Executes during object creation, after setting all properties.
function ListTrainModelType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListTrainModelType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListBoxUseModelPark.
function ListBoxUseModelPark_Callback(hObject, eventdata, handles)
% hObject    handle to ListBoxUseModelPark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListBoxUseModelPark contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBoxUseModelPark


% --- Executes during object creation, after setting all properties.
function ListBoxUseModelPark_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBoxUseModelPark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListBoxUseModelTurbine.
function ListBoxUseModelTurbine_Callback(hObject, eventdata, handles)
% hObject    handle to ListBoxUseModelTurbine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListBoxUseModelTurbine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListBoxUseModelTurbine


% --- Executes during object creation, after setting all properties.
function ListBoxUseModelTurbine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListBoxUseModelTurbine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function UseTimeFrom_Callback(hObject, eventdata, handles)
% hObject    handle to UseTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UseTimeFrom as text
%        str2double(get(hObject,'String')) returns contents of UseTimeFrom as a double


% --- Executes during object creation, after setting all properties.
function UseTimeFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UseTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function UseTimeTo_Callback(hObject, eventdata, handles)
% hObject    handle to UseTimeTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UseTimeTo as text
%        str2double(get(hObject,'String')) returns contents of UseTimeTo as a double


% --- Executes during object creation, after setting all properties.
function UseTimeTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UseTimeTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TrainButton.
function TrainButton_Callback(hObject, eventdata, handles)
% hObject    handle to TrainButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LookBack=2; %How Many steps to look back
TrainStatus=get(handles.TrainButton,'BackgroundColor');
if ~(TrainStatus(2)==1 && TrainStatus(1)==0)
    return
end
set(handles.TrainButton,'BackgroundColor',[1 1 0])
set(handles.ButtonSave,'BackgroundColor',[1 1 0])
MyFeatures=get(handles.ListTrainChoices,'String');
MyConditions='ActPower>100';
if LookBack>=1
    NewFeatures=cell(LookBack*size(MyFeatures,1),1);
    for LB=1:LookBack
        for NF=1:length(MyFeatures)
            NewFeatures((LB-1)*length(MyFeatures)+NF)={[MyFeatures{NF} '(' num2str(LB) ')']};
        end
        MyConditions=[MyConditions ' & ActPower(' num2str(LB) ')>100']; %#ok
    end
    MyFeatures=[MyFeatures; NewFeatures];
end
MyTarget=get(handles.ListUseTarget,'String');
training.type=handles.MyModels{get(handles.ListTrainModelType,'Value')};
if strcmpi(training.type,'neural')
    training.trainParam.hiddenUnitsFactor=6;
    training.trainParam.epochs=40;
end
training.timeFrom=get(handles.EditTrainTimeFrom,'string');
training.timeTo=get(handles.EditTrainTimeTo,'String');
training.standartSamplesMin=500;
training.standartSamplesMax=1000;
AllTurbines=get(handles.ListTrainTurbine,'String');
MyTurbine=str2num(AllTurbines(get(handles.ListTrainTurbine,'Value'),:)); %#ok
drawnow
[model,stats]=jobBuilder('MyModel',training,MyTarget,MyFeatures',MyConditions,MyTurbine);
if isempty(model)
    set(handles.TrainButton,'BackgroundColor',[1 0 0])
    pause(0.25)
    set(handles.TrainButton,'BackgroundColor',[0 1 0])
    set(handles.ButtonSave,'BackgroundColor',[0 1 0])
    return
end
job = JobDescription(model);
job.model.errorConditions = ['abs(target-model)>4*' num2str(stats.stats.s)];
job.time.start=training.timeFrom;
job.time.stop= training.timeTo;
handles.job=job;
set(handles.TrainButton,'BackgroundColor',[0 1 0])
set(handles.ButtonSave,'BackgroundColor',[0 1 0])
set(handles.UseButton,'BackgroundColor',[0 1 0])
guidata(hObject, handles);



% --- Executes on selection change in ListTrainFeatures.
function ListTrainFeatures_Callback(hObject, eventdata, handles)
% hObject    handle to ListTrainFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListTrainFeatures contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListTrainFeatures
MyTDIs=handles.MyTDIs;
MyChoices=get(handles.ListTrainChoices,'String');
MyValue=get(handles.ListTrainFeatures,'Value');
MyChoices=unique([MyChoices;MyTDIs(MyValue)]);
set(handles.ListTrainChoices,'String',MyChoices)
if length(MyChoices)==1
    set(handles.ListTrainChoices,'Value',1)
end
if ~isempty(get(handles.ListUseTarget,'String'))
    set(handles.TrainButton,'backgroundcolor',[0 1 0])
end

% --- Executes during object creation, after setting all properties.
function ListTrainFeatures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListTrainFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListTrainChoices.
function ListTrainChoices_Callback(hObject, eventdata, handles)
% hObject    handle to ListTrainChoices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListTrainChoices contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListTrainChoices
MyChoices=get(handles.ListTrainChoices,'String');
if ~length(MyChoices)==0
    MyValue=get(handles.ListTrainChoices,'Value');
    MyChoices(MyValue)=[];
    if MyValue>1
        MyValue=MyValue-1;
    end
    set(handles.ListTrainChoices,'String',MyChoices)
    set(handles.ListTrainChoices,'Value',MyValue)
end


% --- Executes during object creation, after setting all properties.
function ListTrainChoices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListTrainChoices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox23.
function listbox23_Callback(hObject, eventdata, handles)
% hObject    handle to listbox23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox23 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox23


% --- Executes during object creation, after setting all properties.
function listbox23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox24.
function listbox24_Callback(hObject, eventdata, handles)
% hObject    handle to listbox24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox24 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox24


% --- Executes during object creation, after setting all properties.
function listbox24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox25.
function listbox25_Callback(hObject, eventdata, handles)
% hObject    handle to listbox25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox25 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox25


% --- Executes during object creation, after setting all properties.
function listbox25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox26.
function listbox26_Callback(hObject, eventdata, handles)
% hObject    handle to listbox26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox26 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox26


% --- Executes during object creation, after setting all properties.
function listbox26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox27.
function listbox27_Callback(hObject, eventdata, handles)
% hObject    handle to listbox27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox27 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox27


% --- Executes during object creation, after setting all properties.
function listbox27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListUsePark.
function ListUsePark_Callback(hObject, eventdata, handles)
% hObject    handle to ListUsePark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListUsePark contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListUsePark
MyPark=handles.ParkNames(get(handles.ListUsePark,'Value'));
set(handles.ListUseTurbine,'String',['    all'; num2str(sort(turbine_getId(cell2mat(MyPark))'))])
set(handles.ListUseTurbine,'Value',1)

% --- Executes during object creation, after setting all properties.
function ListUsePark_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListUsePark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListUseTurbine.
function ListUseTurbine_Callback(hObject, eventdata, handles)
% hObject    handle to ListUseTurbine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListUseTurbine contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListUseTurbine


% --- Executes during object creation, after setting all properties.
function ListUseTurbine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListUseTurbine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditUseTimeFrom_Callback(hObject, eventdata, handles)
% hObject    handle to EditUseTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditUseTimeFrom as text
%        str2double(get(hObject,'String')) returns contents of EditUseTimeFrom as a double


% --- Executes during object creation, after setting all properties.
function EditUseTimeFrom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditUseTimeFrom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditUseTimeTo_Callback(hObject, eventdata, handles)
% hObject    handle to EditUseTimeTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditUseTimeTo as text
%        str2double(get(hObject,'String')) returns contents of EditUseTimeTo as a double


% --- Executes during object creation, after setting all properties.
function EditUseTimeTo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditUseTimeTo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UseButton.
function UseButton_Callback(hObject, eventdata, handles)
% hObject    handle to UseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%try
    set(handles.UseButton,'BackgroundColor',[1 1 0])
    if  isfield(handles,'job')
        TimeFrom=get(handles.EditUseTimeFrom,'string');
        TimeTo=get(handles.EditUseTimeTo,'String');
        AllTurbines=get(handles.ListUseTurbine,'String');
        MyTurbine=AllTurbines(get(handles.ListUseTurbine,'Value'),:); %#ok
        MyType=handles.MyModels{get(handles.ListTrainModelType,'Value')}; %#ok
        drawnow
        
        if strcmpi(strtrim(MyTurbine),'all')
            MyTurbine=turbine_getId(handles.ParkNames{get(handles.ListUsePark,'value')});
        else
            MyTurbine=str2num(MyTurbine);%#ok
        end
        for MyTurbine=MyTurbine;
            filename=fileserver.createPerformFilename('MyModel',MyTurbine);
            performFile = sprintf('%s%s',fileserver.Config.PERFORM_PATH,filename);
            deleteFiles=dir(performFile);
            if ~isempty(deleteFiles)
                delete(performFile)
            end 
            fileserver.createJobs(MyTurbine,handles.job)
            load(performFile)
            [~,td,~]=evalModel(MyTurbine,handles.job.model,datenum(TimeFrom,31),datenum(TimeTo,31));
            Perform.td.model=td; %#ok
            save(performFile,'Perform')
        end
    end
    files=dir([fileserver.Config.PERFORM_PATH '*MyModel*']);
    if ~isempty(files)
        fileserver.showModel('MyModel')
    else
        set(handles.UseButton,'BackgroundColor',[1 0 0])
        pause(0.25)
        set(handles.UseButton,'BackgroundColor',[0 1 0])
    end
    set(handles.UseButton,'BackgroundColor',[0 1 0])
    guidata(hObject, handles);



% --- Executes on selection change in ListUseFeatures.
function ListUseFeatures_Callback(hObject, eventdata, handles)
% hObject    handle to ListUseFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListUseFeatures contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListUseFeatures
MyTDIs=handles.MyTDIs;
MyValue=get(handles.ListUseFeatures,'Value');
set(handles.ListUseTarget,'String',MyTDIs(MyValue))
if length(handles.ListUseTarget)==1
    set(handles.ListUseTarget,'Value',1)
end
if ~isempty(get(handles.ListTrainChoices,'String'))
    set(handles.TrainButton,'backgroundcolor',[0 1 0])
end


% --- Executes during object creation, after setting all properties.
function ListUseFeatures_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListUseFeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListUseTarget.
function ListUseTarget_Callback(hObject, eventdata, handles)
% hObject    handle to ListUseTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListUseTarget contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListUseTarget


% --- Executes during object creation, after setting all properties.
function ListUseTarget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListUseTarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.mat');
load([path file]')
handles.job=job;
%set(handles.TrainButton,'BackgroundColor',[0 1 0])
set(handles.ButtonSave,'BackgroundColor',[0 1 0])
set(handles.UseButton,'BackgroundColor',[0 1 0])
set(handles.Load,'BackgroundColor',[0 1 0])
guidata(hObject, handles);


% --- Executes on button press in ButtonSave.
function ButtonSave_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%try
    if isfield(handles,'job')
        job=handles.job; %#ok

%         Features=get(handles.ListTrainChoices,'String')';
%         Target=get(handles.ListUseTarget,'String');
%         ModelValue=get(handles.ListTrainModelType,'Value');
%         TimeFrom=get(handles.EditTrainTimeFrom,'String');
%         TimeTo=get(handles.EditTrainTimeTo,'String');
        [file,path] = uiputfile('*.mat','Save Model');
        save([path file],'job')
    end
%end


% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Delete,'BackgroundColor',[1 0 0])
files=dir([fileserver.Config.PERFORM_PATH '*MyModel*']);
for x=1:length(files)
    delete([fileserver.Config.PERFORM_PATH files(x).name])
end
set(handles.Delete,'BackgroundColor',[0 1 0])

