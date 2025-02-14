// 2025 (c) Luis Espino

using System;
using System.Runtime.InteropServices;

// SparseMatrix with orthogonal pointers,
// with necessary headers to link

public unsafe class SparseNode
{
    // node content
    public string Data;
    // nodex indexes
    public int Row, Col;
    // orthogonal pointers
    public SparseNode* Up;
    public SparseNode* Down;
    public SparseNode* Right;
    public SparseNode* Left;
}

public unsafe class SparseMatrix
{
    // pointer to origin of SpareMatrix
    private SparseNode* Head = null;

    public SparseMatrix()
    {
        // origin index (0,0)
        // "XX" for empty node but with necessary pointers
        Head = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
        *Head = new SparseNode{ Data = "XX", Row = 0, Col = 0, 
                                Up = null, Down = null, 
                                Right = null, Left = null };
    }

    // insert method
    public void Add(string data, int row, int col)
    {
        // temporal iterators
        SparseNode* colIter = null; // column iterator
        SparseNode* colIterP = null; // previous column iterator
        SparseNode* rowIter = null; // row iterator
        SparseNode* rowIterP = null; // previuos row iterator

        // boolean value for update orthogonal pointers
        bool update = false;

        // temporal insert node
        SparseNode* newNode = null;

        // search column to link
        colIter = Head; 
        colIterP = null; 
        while (colIter != null)
        {
            if (colIter->Col == col)
            {
                // column found, now search row
                rowIter = colIter; 
                rowIterP = null; 
                while (rowIter != null)
                {
                    if (rowIter->Row == row)
                    {
                        // row found, now update
                        rowIter->Data = data;
                        update = true;
                        break;
                    }
                    else if (rowIter->Row > row)
                    {
                        // row and null not found, now add at the middle
                        newNode = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                        *newNode = new SparseNode{  Data = data, Row = row, Col = col, 
                                                    Up = rowIterP, Down = rowIter, 
                                                    Right = null, Left = null };
                        rowIterP->Down = newNode;
                        rowIter->Up = newNode;
                        if (col == 0) update = true;
                        break;
                    }
                    else if (rowIter->Down == null)
                    {
                        // row not found, now add at the end
                        newNode = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                        *newNode = new SparseNode{  Data = data, Row = row, Col = col, 
                                                    Up = rowIter, Down = null, 
                                                    Right = null, Left = null };
                        rowIter->Down = newNode;
                        if (col == 0) update = true;
                        break;
                    }
                    rowIterP = rowIter;
                    rowIter = rowIter->Down;
                }
                break;
            }
            else if (colIter->Col > col)
            {
                // column not found, now add at the middle
                if (row == 0)
                {
                    // row found, now add node
                    newNode = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                    *newNode = new SparseNode{  Data = data, Row = row, Col = col, 
                                                Up = null, Down = null, 
                                                Right = colIter, Left = colIterP };
                    colIterP->Right = newNode;
                    colIter->Left = newNode;
                    update = true;
                }
                else
                {
                    // row not found, add neccesary empty node
                    SparseNode* tmp = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                    *tmp = new SparseNode{  Data = "XX", Row = 0, Col = col, 
                                            Up = null, Down = null, 
                                            Right = colIter, Left = colIterP };
                    colIterP->Right = tmp;
                    colIter->Left = tmp;
                    // add node
                    newNode = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                    *newNode = new SparseNode{  Data = data, Row = row, Col = col, 
                                                Up = null, Down = newNode, 
                                                Right = null, Left = null };
                    newNode->Up = tmp;
                }
                break;
            }
            else if (colIter->Right == null)
            {
                // column not found, now add at the end
                if (row == 0)
                {
                    // row found, now add node
                    newNode = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                    *newNode = new SparseNode{  Data = data, Row = row, Col = col, 
                                                Up = null, Down = null, 
                                                Right = null, Left = colIter };

                    colIter->Right = newNode;
                    update = true;
                }
                else
                {
                    // row not found, add neccesary empty node
                    SparseNode* tmp = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                    *tmp = new SparseNode{  Data = "XX", Row = 0, Col = col, 
                                            Up = null, Down = null, 
                                            Right = null, Left = colIter };                     
                    colIter->Right = tmp;
                    // add node
                    newNode = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                    *newNode = new SparseNode{  Data = data, Row = row, Col = col, 
                                                Up = null, Down = null, 
                                                Right = null, Left = null };
                    tmp->Down = newNode;
                    newNode->Up = tmp;
                }
                break;
            }
            colIterP = colIter;
            colIter = colIter->Right;
        }

        // successful addition in column (not update)
        // now search row to link
        if (!update)
        {
            rowIter = Head;
            rowIterP = null;
            while (rowIter != null)
            {
                if (rowIter->Row == row)
                {
                    // row found, now search column
                    colIter = rowIter;
                    colIterP = null;
                    while (colIter != null)
                    {
                        if (colIter->Col > col)
                        {
                            // column and null not found
                            // now add node link at the middle
                            newNode->Left = colIterP;
                            newNode->Right = colIter;
                            colIterP->Right = newNode;
                            colIter->Left = newNode;
                            break;
                        }
                        else if (colIter->Right == null)
                        {
                            // column not found
                            // now add link at the end
                            newNode->Left = colIter;
                            colIter->Right = newNode;
                            break;
                        }
                        colIterP = colIter;
                        colIter = colIter->Right;
                    }
                    break;
                }
                else if (rowIter->Row > row)
                {
                    // row and null not found
                    // now add node link at the middle
                    if (col == 0)
                    {
                        // column found, now add node link
                        newNode->Up = rowIterP;
                        newNode->Down = rowIter;
                        rowIterP->Down = newNode;
                        rowIter->Up = newNode;
                    }
                    else
                    {
                        // column not found, add neccesary empty node
                        SparseNode* tmp = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                        *tmp = new SparseNode{  Data = "XX", Row = row, Col = 0, 
                                            Up = rowIterP, Down = rowIter, 
                                            Right = null, Left = null };                     
                        rowIterP->Down = tmp;
                        rowIter->Up = tmp;
                        // add link
                        tmp->Right = newNode;
                        newNode->Left = tmp;
                    }
                    break;
                }
                else if (rowIter->Down == null)
                {
                    // row not found, now add link at the end
                    if (col == 0)
                    {
                        // column found, now add link
                        newNode->Up = rowIterP;
                        newNode->Down = rowIter;
                        rowIterP->Down = newNode;
                        rowIter->Up = newNode;
                    }
                    else
                    {
                        // column not found, now add necessary empty node
                        SparseNode* tmp = (SparseNode*)Marshal.AllocHGlobal(sizeof(SparseNode));
                        *tmp = new SparseNode{  Data = "XX", Row = row, Col = 0, 
                                            Up = rowIter, Down = null, 
                                            Right = null, Left = null };                     
                        rowIter->Down = tmp;
                        // add node link
                        tmp->Right = newNode;
                        newNode->Left = tmp;
                    }
                    break;
                }
                rowIterP = rowIter;
                rowIter = rowIter->Down;
            }
        }
    }

    // print method
    public void Print(int dim)
    {
        SparseNode* r = Head;
        
        // traverse matrix by rows
        for (int i = 0; i < dim; ++i)
        {
            if (r != null)
            {
                if (r->Row == i)
                {
                    // row found
                    SparseNode* c = r;

                    // traverse row matrix by columns
                    for (int j = 0; j < dim; ++j)
                    {
                        if (c != null)
                        {
                            if (c->Col == j)
                            {
                                // print found node
                                Console.Write(c->Data + " ");
                                c = c->Right;
                            }
                            else
                            {
                                // node not found
                                Console.Write("-- ");
                            }
                        }
                        else
                        {
                            // node not found
                            Console.Write("-- ");
                        }
                    }
                    r = r->Down;
                }
                else
                {
                    // entire row not found
                    for (int j = 0; j < dim; ++j)
                    {
                        Console.Write("-- ");
                    }
                }
            }
            else
            {
                // matrix not found
                for (int j = 0; j < dim; ++j)
                {
                    Console.Write("-- ");
                }
            }
            Console.WriteLine();
        }
    }
}

class Program
{
    static void Main()
    {
        // instance on the stack, content on the heap
        SparseMatrix sp = new SparseMatrix();
        sp.Add("00", 0, 0);
        sp.Add("02", 0, 2);
        sp.Add("03", 0, 3);
        sp.Add("11", 1, 1);
        sp.Add("22", 2, 2);
        sp.Add("30", 3, 0);
        sp.Add("33", 3, 3);
        sp.Print(4);
    }
}

