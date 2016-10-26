function [A Omega Phi Alpha Beta N b str val ] = get_parameters(hObject, eventdata, handles)
A = str2double(get(handles.A,'String'));
Omega = str2double(get(handles.Omega,'String'));
Phi = str2double(get(handles.Phi,'String'));
Alpha = str2double(get(handles.Alpha,'String'));
Beta = str2double(get(handles.Beta,'String'));
N = str2double(get(handles.N,'String'));
b = str2double(get(handles.b,'String'));
str =get(handles.FunctionsMenu,'String');
val =get(handles.FunctionsMenu,'Value');
end