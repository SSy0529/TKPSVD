function C = tkron(A,B)
%  C = tkron(A,B)
% ---------------
% Returns the Kronecker product of two input tensors A,B.
%
% C         =   multiway array, Kronecker product of A with B.
%
% A,B       =   multiway array, tensors of the same order.
%
% Reference
% ---------
%
% 02/206, Batselier Kim

% C{i,j,k} = C{(i2,i1), (j2,j1), (k2, k1)} = B{i2,j2,k2} * A{i1,j1,k1}
n1=size(A);
n2=size(B);
d1=length(n1);
d2=length(n2);

% append with ones if the dimensions are not the same (due to Matlab's
% removal of trailing ones in the dimension)
if d1 > d2
    d2=[d2 ones(1,d1-d2)];
elseif d2 > d1
    d1=[d1 ones(1,d2-d1)];
end

c=kron(A(:),B(:)); %compute all entries
% now reshape the vector into the desired tensor
permI=[];
for i=1:d1
    permI=[permI i i+d1];
end
C=reshape(permute(reshape(c,[n2 n1]),[1 6 2 7 3 8 4 9 5 10]),n1.*n2);
