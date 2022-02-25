//
//  CommonTypes.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import Foundation

public typealias VoidClosure = () -> Void
public typealias VoidInputClosure<O> = () -> O
public typealias VoidOutputClosure<I> = (I) -> Void
public typealias Closure<I, O> = (I) -> O
