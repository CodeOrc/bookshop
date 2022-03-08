using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Cart
/// </summary>
public class Cart
{
    public int Id { get; set; }
    public string BookName { get; set; }
    public int Price { get; set; }
    public string PreviewImg { get; set; }
    public int Amount { get; set; }
    public int subtotal { get; set; }
}