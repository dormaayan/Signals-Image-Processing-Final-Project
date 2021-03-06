function varargout = gui(varargin)


% Last Modified by GUIDE v2.5 26-Oct-2016 08:40:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, ~, handles)
varargout{1} = handles.output;

function initialize_gui(~, handles, isreset)
global s qss;
s = NaN;
qss = NaN;
set(handles.A,'String','');
set(handles.Omega,'String','');
set(handles.Phi,'String','');
set(handles.Alpha,'String','');
set(handles.Beta,'String','');
set(handles.b,'String','');
set(handles.N,'String','');
set(handles.mseT,'String','');
set(handles.n_info,'String','');
set(handles.b_info,'String','');
set(handles.MSEM,'String','');
set(handles.nM,'String','');
set(handles.bM,'String','');
cla(handles.axes1);
cla(handles.axes2);
set(handles.FunctionsMenu,'Value',1);
set(handles.A,'visible','of');
set(handles.A_t,'visible','of');
set(handles.Omega,'visible','of');
set(handles.Omega_t,'visible','of');
set(handles.Phi,'visible','of');
set(handles.Phi_t,'visible','of');
set(handles.Alpha,'visible','off');
set(handles.Alpha_t,'visible','off');
set(handles.Beta,'visible','off');
set(handles.Beta_t,'visible','off');
set(handles.N,'visible','off');
set(handles.N_t,'visible','off');
set(handles.b,'visible','off');
set(handles.b_t,'visible','off');
set(handles.computation_method,'visible','off');
set(handles.computation_method,'visible','off');
set(handles.specific_values,'visible','off');
set(handles.best_values,'visible','off');
set(handles.bit_budget,'visible','off');
set(handles.bit_budget_t,'visible','off');
% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
initialize_gui(gcbf, handles, true);

% --- Executes on button press Apply.
function Apply_Callback(hObject, eventdata, handles)
global s qss;
t_grid = 0:0.00001:1;
A = str2double(get(handles.A,'String'));
Omega = str2double(get(handles.Omega,'String'));
Phi = str2double(get(handles.Phi,'String'));
Alpha = str2double(get(handles.Alpha,'String'));
Beta = str2double(get(handles.Beta,'String'));
N = str2double(get(handles.N,'String'));
b = str2double(get(handles.b,'String'));
str =get(handles.FunctionsMenu,'String');
val =get(handles.FunctionsMenu,'Value');

switch str{val};
    case 'Function - 1'
        s = s1(A,Omega,Phi,t_grid);
    case 'Function - 2'
        s = s2(A,Omega,Phi,t_grid);
    case 'Function - 3'
        s = s3(A,Omega,Alpha,Phi,t_grid);
    case 'Function - 4'
        s = s4(A,Omega,Alpha,Phi,t_grid);
    case 'Function - 5'
        s = s5(A,Beta,Omega,Alpha,Phi,t_grid);
end
if ~strcmp(str{val},'Please Select a Function'),
    if get(handles.specific_values,'Value')==1,
        bitBudget = N*b;
        qss = sampleAndQuantize(s,N,b);
        min_b = b;
    end
    if get(handles.best_values,'Value')==1,
        bitBudget = str2double(get(handles.bit_budget,'String'));
        switch str{val};
            case 'Function - 1'
                [bNumerical,NNumerical,mseNumerical] = func1Numerically(Omega,Phi,A,bitBudget);
            case 'Function - 2'
                [bNumerical,NNumerical,mseNumerical] = func2Numerically(Omega,Phi,A,bitBudget);
            case 'Function - 3'
                [bNumerical,NNumerical,mseNumerical] = func3Numerically(Omega,Phi,A,Alpha,bitBudget);
            case 'Function - 4'
                [bNumerical,NNumerical,mseNumerical] = func4Numerically(Omega,Phi,A,Alpha,bitBudget);
            case 'Function - 5'
                [bNumerical,NNumerical,mseNumerical] = func5Numerically(Omega,Phi,A,Alpha,Beta,bitBudget);
        end
        qss = sampleAndQuantize(s,bitBudget,1);
        mse = mseProject(s,qss);
        min_b = 1;
        for b=2:1:16,
            tempQss = sampleAndQuantize(s,floor(bitBudget/b),b);
            tempMse = mseProject(s,tempQss);
            if tempMse<mse,
                qss = tempQss;
                mse = tempMse;
                min_b = b;
            end
        end
        set(handles.bM,'String',bNumerical);
        set(handles.nM,'String',NNumerical);
        set(handles.MSEM,'String',mseNumerical);
    end
    qss = decompress_1d(qss,numel(t_grid));
    plot(handles.axes1,t_grid,s);
    plot(handles.axes2,t_grid,qss);
    set(handles.mseT,'String',mseProject(s,qss));
    set(handles.b_info,'String',min_b);
    set(handles.n_info,'String',floor(bitBudget/min_b));
end



% --- Executes on selection change in FunctionsMenu.
function FunctionsMenu_Callback(hObject, ~, handles)
set(handles.A,'String','');
set(handles.bit_budget,'String','');
set(handles.Omega,'String','');
set(handles.Phi,'String','');
set(handles.Alpha,'String','');
set(handles.Beta,'String','');
set(handles.b,'String','');
set(handles.N,'String','');
set(handles.mseT,'String','');
set(handles.n_info,'String','');
set(handles.b_info,'String','');
set(handles.MSEM,'String','');
set(handles.nM,'String','');
set(handles.bM,'String','');
cla(handles.axes1);
cla(handles.axes2);
set(handles.A,'visible','on');
set(handles.bit_budget,'visible','off');
set(handles.bit_budget_t,'visible','off');
set(handles.A_t,'visible','on');
set(handles.Omega,'visible','on');
set(handles.Omega_t,'visible','on');
set(handles.Phi,'visible','on');
set(handles.Phi_t,'visible','on');
set(handles.N,'visible','on');
set(handles.N_t,'visible','on');
set(handles.b,'visible','on');
set(handles.b_t,'visible','on');
set(handles.computation_method,'visible','on');
set(handles.specific_values,'visible','on');
set(handles.specific_values,'Value',1);
set(handles.best_values,'Value',0);
set(handles.best_values,'visible','on');
str =get(hObject,'String');
val =get(hObject,'Value');
switch str{val};
    case 'Please Select a Function'
        initialize_gui(gcbf, handles, true);
    case 'Function - 1'
        set(handles.A_t,'String','A :');
        set(handles.Omega_t,'String','Omega :');
        set(handles.Alpha,'visible','off');
        set(handles.Alpha_t,'visible','off');
        set(handles.Beta,'visible','off');
        set(handles.Beta_t,'visible','off');
    case 'Function - 2'
        set(handles.A_t,'String','A :');
        set(handles.Omega_t,'String','Omega :');
        set(handles.Alpha,'visible','off');
        set(handles.Alpha_t,'visible','off');
        set(handles.Beta,'visible','off');
        set(handles.Beta_t,'visible','off');
    case 'Function - 3'
        set(handles.A_t,'String','A :');
        set(handles.Omega_t,'String','Omega_0 :');
        set(handles.Alpha,'visible','on');
        set(handles.Alpha_t,'visible','on');
        set(handles.Beta,'visible','off');
        set(handles.Beta_t,'visible','off');
    case 'Function - 4'
        set(handles.A_t,'String','A :');
        set(handles.Omega_t,'String','Omega_0 :');
        set(handles.Alpha,'visible','on');
        set(handles.Alpha_t,'visible','on');
        set(handles.Beta,'visible','off');
        set(handles.Beta_t,'visible','off');
    case 'Function - 5'
        set(handles.A_t,'String','A_0 :');
        set(handles.Omega_t,'String','Omega_0 :');
        set(handles.Phi,'visible','on');
        set(handles.Phi_t,'visible','on');
        set(handles.Alpha,'visible','on');
        set(handles.Alpha_t,'visible','on');
        set(handles.Beta,'visible','on');
        set(handles.Beta_t,'visible','on');
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in playS.
function playS_Callback(hObject, eventdata, handles)
global s;
if ~isnan(s),
    sound(s,25000);
end


% --- Executes on button press in SSQ.
function SSQ_Callback(hObject, eventdata, handles)
global qss;
if ~isnan(qss),
    sound(qss,25000);
end

% --- Executes on button press in specific_values.
function specific_values_Callback(hObject, eventdata, handles)
set(handles.N,'visible','on');
set(handles.N_t,'visible','on');
set(handles.b,'visible','on');
set(handles.b_t,'visible','on');
set(handles.bit_budget,'visible','off');
set(handles.bit_budget_t,'visible','off');


% --- Executes on button press in best_values.
function best_values_Callback(hObject, eventdata, handles)
set(handles.N,'visible','off');
set(handles.N_t,'visible','off');
set(handles.b,'visible','off');
set(handles.b_t,'visible','off');
set(handles.bit_budget,'visible','on');
set(handles.bit_budget_t,'visible','on');
%My Own Functions

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%From Here - All The Irrelevant Code !!!!
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function figure1_CreateFcn(hObject, eventdata, handles)
set(handles.figure1, 'units', 'normalized', 'position', [0.05 0.15 0.9 0.8]);


function b_Callback(hObject, eventdata, handles)

function N_Callback(hObject, eventdata, handles)

function pushbutton1_Callback(~, ~, ~)

function popupmenu1_Callback(hObject, eventdata, handles)

function pushbutton5_Callback(hObject, eventdata, handles)

function figure1_WindowButtonDownFcn(hObject, eventdata, handles)

function figure1_WindowButtonMotionFcn(hObject, eventdata, handles);

function figure1_WindowButtonUpFcn(hObject, eventdata, handles)

function figure1_WindowKeyPressFcn(~, eventdata, handles)

function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)

function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)

function Clear_ButtonDownFcn(hObject, eventdata, handles)

function edit14_Callback(hObject, eventdata, handles)

function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu3_Callback(hObject, eventdata, handles)

function edit12_Callback(hObject, eventdata, handles)

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit10_Callback(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, ~, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function FunctionsMenu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function b_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function checkbox1_Callback(hObject, eventdata, handles)

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)

function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Omega_Callback(hObject, eventdata, handles)

function Omega_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit13_Callback(hObject, eventdata, handles)

function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_Callback(hObject, eventdata, handles)

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function A_Callback(hObject, eventdata, handles)

function A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Alpha_Callback(hObject, eventdata, handles)

function Alpha_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Phi_Callback(hObject, eventdata, handles)

function Phi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit19_Callback(hObject, eventdata, handles)

function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Beta_Callback(hObject, eventdata, handles)

function Beta_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox3_Callback(hObject, eventdata, handles)

function listbox3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox2_Callback(hObject, eventdata, handles)

function listbox2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function N_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bit_budget_Callback(hObject, eventdata, handles)
% hObject    handle to bit_budget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bit_budget as text
%        str2double(get(hObject,'String')) returns contents of bit_budget as a double


% --- Executes during object creation, after setting all properties.
function bit_budget_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bit_budget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
